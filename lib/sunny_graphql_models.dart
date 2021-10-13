import 'dart:developer';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart' as lang;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sunny_sdk_core/api_exports.dart';
import 'package:sunny_sdk_core/mverse.dart';
import 'package:sunny_sdk_core/mverse/m_base_model.dart';
import 'package:inflection3/inflection3.dart';

import 'graph_client_config.dart';
import 'graph_client_serialization.dart';

mixin GraphInputMixin implements GraphInput {
  T get<T>(String key) {
    return this[key] as T;
  }

  void takeFromMap(Map<String, dynamic> map, {bool copyEntries = true}) {
    map.forEach((key, value) {
      this[key] = value;
    });
  }
}

abstract class GraphInput implements MBaseModel {
  void operator []=(key, dynamic value);
  dynamic operator [](key);
  T get<T>(String key);
  Map<String, dynamic>? toJson();

  // Object? relatedJson();
}

DocumentNode DocumentNodes(List<DocumentNode> nodes) {
  return DocumentNode(definitions: [...nodes.expand((n) => n.definitions)]);
}

mixin JoinTypeMixin<N extends Entity> {
  N? get node;

  String? get id => node?.mkey?.mxid;

  dynamic toJson();
}

abstract class BaseSunnyEntity with MBaseModelMixin {
  String? get id;

  // Map<String, dynamic> toMap();

  MKey? get mkey {
    return id == null ? null : MKey.fromType(mtype, id!);
  }

  Map<String, dynamic> toMap();

  dynamic operator [](key) => throw "Not implemented";

  void operator []=(String key, value) => throw "Not implemented";

  MSchemaRef get mtype;

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    return other is BaseSunnyEntity && other.toMap() == this.toMap();
  }

  @override
  int get hashCode {
    return this.toMap().hashCode;
  }

  dynamic clone() {
    return GraphClientConfig.read(toMap(), typeName: mtype.artifactId!.capitalize(), isNullable: false);
  }

  void takeFrom(dynamic source) {
    throw "Not implemented";
  }

  void takeFromMap(Map<String, dynamic> map, {bool copyEntries = true}) {
    map.forEach((key, value) {
      this[key] = value;
    });
  }
}

abstract class GraphQueryResolver {
  DocumentNode? getQuery(String name);

  DocumentNode? getOperation(String entityName, String op) => getQuery('${entityName}${op.capitalize()}Op');
}

abstract class GraphApi<T extends BaseSunnyEntity, C extends GraphInput, U extends GraphInput> {
  GraphQLClient client();

  GraphSerializer get serializer;

  GraphQueryResolver get resolver;

  MSchemaRef get mtype;

  String get entityName => mtype.artifactId!.capitalize();
  String get entityPlural => pluralize(entityName);

  String get artifactId => mtype.artifactId!;
  String get artifactPlural => pluralize(artifactId);

  final Map<String, DocumentNode> _relatedQueries = {};

  Future<T> create(C input) async {
    var result = await this.client().queryManager.mutate(MutationOptions(
        document: resolver.getOperation(entityName, 'create')!,
        operationName: "create${entityName}",
        variables: {"input": input.toJson()}));

    if (result.hasException) {
      throw result.exception!;
    }

    return this.serializer.read(result.data!["create${entityPlural}"]["${entityPlural.uncapitalize()}"][0],
        typeName: entityName, isNullable: false);
  }

  Future<T> update(String id, U input) async {
    final _update = input.toJson();
    print("id: $id");
    print(json.encode(_update));
    var result = await this.client().queryManager.mutate(MutationOptions(
            document: resolver.getOperation(entityName, 'update')!,
            operationName: "update${entityName}",
            variables: {
              "id": id,
              "update": _update,
            }));

    if (result.hasException) {
      throw result.exception!;
    }

    return this
        .serializer
        .read(result.data!["update${entityPlural}"]["${artifactPlural}"][0], typeName: entityName, isNullable: false);
  }

  Future<int> delete(String id) async {
    var result = await this.client().queryManager.mutate(
          MutationOptions(
            document: resolver.getOperation(entityName, 'delete')!,
            operationName: "delete${entityName}",
            variables: {"id": id},
          ),
        );

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data!["delete${entityPlural}"]['nodesDeleted'] as int;
  }

  Future<List<T>> list([Object filters = const {}]) async {
    var result = await this.client().queryManager.mutate(MutationOptions(
        document: resolver.getOperation(entityName, 'list')!, operationName: "list${entityName}", variables: {"where": filters}));

    if (result.hasException) {
      throw result.exception!;
    }

    return this.serializer.readList(
          result.data![entityPlural.uncapitalize()],
          typeName: entityName,
          isNullable: false,
        );
  }

  Future<T?> load(String id) async {
    var result = await this.client().queryManager.mutate(MutationOptions(
        document: resolver.getOperation(entityName, 'load')!, operationName: "load${entityName}", variables: {"id": id}));

    if (result.hasException) {
      throw result.exception!;
    }
    var list = result.data!["${artifactPlural}"] as List?;
    return this.serializer.read(list?.firstOr(), typeName: entityName, isNullable: true);
  }

  Future<T> getOrCreate(String id, {required C create()}) async {
    final existing = await load(id);
    return existing ?? await this.create(create());
  }

  Future<T> get(String id) async {
    final record = await load(id);
    return record ?? nullPointer('No $entityName record for $id');
  }

  Future<double> count() async {
    var result = await this.client().queryManager.mutate(MutationOptions(
        document: resolver.getOperation(entityName, 'count')!, operationName: "count${entityPlural}", variables: {}));

    if (result.hasException) {
      throw result.exception!;
    }

    return result.data!["${artifactPlural}Count"] as double;
  }

  Future<T> loadRelated<T>(
      {required String id,
      required String relatedType,
      required String field,
      required bool isNullable,
      required DocumentNode fragments}) async {
    final loaded = await _executeLoadRelated(id: id, relatedType: relatedType, fieldName: field, fragments: fragments);
    return this.serializer.read<T>(loaded, typeName: relatedType, isNullable: isNullable);
  }

  //
  // Future<T> updateRelated<T>({
  //   required String id,
  //   Map<String, RefInput> related,
  // }) async {
  //   final loaded = await _executeLoadRelated(id: id, relatedType: relatedType, fieldName: field, fragments: fragments);
  //   return this.serializer.read<T>(loaded, typeName: relatedType, isNullable: isNullable);
  // }

  Future<List<T>> loadRelatedList<T>(
      {required String id,
      required String relatedType,
      required bool isNullable,
      required String field,
      required DocumentNode fragments}) async {
    final raw = await _executeLoadRelated(id: id, relatedType: relatedType, fieldName: field, fragments: fragments);
    return this.serializer.readList<T>(raw, typeName: relatedType, isNullable: isNullable);
  }

  DocumentNode _getOrCreateRelatedQuery({required String relatedType, required String fieldName, required String queryName}) {
    return _relatedQueries.putIfAbsent(fieldName, () => gql("""
      query ${queryName}(\$id: ID!) {
        ${artifactPlural}(where: {id: \$id}) {
          ${fieldName} {
            ...${relatedType}Fragment
          }
        }
      }
      """));
  }

  Future _executeLoadRelated({
    required String id,
    required String relatedType,
    required String fieldName,
    required DocumentNode fragments,
  }) async {
    DocumentNode? doc;
    try {
      final queryName = "load${entityName}${fieldName.capitalize()}";
      final gqlQuery = _getOrCreateRelatedQuery(
        relatedType: relatedType,
        fieldName: fieldName,
        queryName: queryName,
      );

      doc = DocumentNodes([gqlQuery, fragments]);

      // print('START! $queryName');
      var result =
          await this.client().queryManager.query(QueryOptions(document: doc, operationName: queryName, variables: {"id": id}));

      if (result.hasException) {
        // print('FROM SERVER! ${result.exception}');
        throw result.exception!;
      }

      // print('END!');

      var r = GraphClientConfig.getDeep(result.data, "${artifactPlural}", 0, fieldName);
      return r;
    } catch (e) {
      print('## -------------------------------------------------------');
      print('## PRINTING FAILED!');
      if (doc == null) print('## NO DOC!');
      doc?.definitions.forEach((element) {
        print(lang.printNode(element));
        print('##---------------------------------------------------');
      });
      print('##-------------------------------------------------------');

      rethrow;
    }
  }
}
