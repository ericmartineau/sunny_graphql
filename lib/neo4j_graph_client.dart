import 'package:gql/ast.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inflection3/inflection3.dart';
import 'package:sunny_graphql/graph_client_serialization.dart';
import 'package:sunny_graphql/refs.dart';
import 'package:sunny_graphql/sunny_graphql_models.dart';
import 'package:sunny_sdk_core/model_exports.dart';

import 'graph_client_config.dart';

typedef GraphObject = Map<String, dynamic>;

class Neo4JGraphQLClient {
  final Getter<GraphQLClient> _client;
  final Neo4JGraphQueryResolver _resolver;
  final GraphSerializer _serializer;

  Neo4JGraphQLClient(this._client, this._resolver, this._serializer);

  Future<dynamic> loadRelatedJson({
    required String entityName,
    required String entityId,
    required String fieldName,
    required String relatedType,
    String? queryName,
    required bool isNullable,
    required bool isJoinType,
    Map<String, Object?>? fixedWhere,
    List<QueryParameter> args = const [],
  }) async {
    final artifactPlural = pluralize(entityName.uncapitalize());
    DocumentNode? gqlQuery;

    try {
      queryName ??= "listRelated$entityName${fieldName.capitalize()}";
      gqlQuery = _resolver.getOrBuildQuery(
          queryName,
          entityName,
          () => _resolver.buildListRelatedQuery(
                thisType: entityName,
                relatedType: relatedType,
                fieldName: fieldName,
                queryName: queryName!,
                where: fixedWhere,
                args: args,
              ));

      var result = await this._client().query(
            QueryOptions(
              document: gqlQuery,
              operationName: queryName,
              variables: {
                "id": entityId,
                for (var arg in args) arg.argument.name: arg.value,
              },
              cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
              fetchPolicy: FetchPolicy.noCache,
            ),
          );

      if (result.hasException) {
        var queryValue = printNode(gqlQuery);
        final translated = GraphClientConfig.translateException(
            GraphOperation(queryName, GraphOperations.listRelated, gqlQuery),
            {
              "where": fixedWhere ?? {},
              "fieldName": fieldName,
              "id": entityId,
              "relatedType": relatedType,
            },
            result.exception!);

        throw translated;
      }

      var raw = GraphClientConfig.getDeep(
          result.data, "${artifactPlural}", 0, fieldName);
      if (raw != null && isJoinType) {
        raw = raw["edges"];
      }
      return raw;
    } catch (e, stack) {
      print(e);
      print(stack);
      print('## -------------------------------------------------------');
      print('## LIST RELATED FAILED!');
      // if (gqlQuery == null) print('## NO DOC!');
      // gqlQuery?.definitions.forEach((element) {
      //   print(lang.printNode(element));
      //   print('##---------------------------------------------------');
      // });
      // print('##-------------------------------------------------------');
      rethrow;
    }
  }

  Future<GraphObject> createEntityJson({
    required String entityName,
    required GraphObject input,
  }) async {
    var operation = _resolver.getOperation(entityName, 'create');
    var result = await this._client().mutate(MutationOptions(
          document: operation!.operation,
          operationName: operation.operationName,
          variables: {"input": input},
        ));

    if (result.hasException) {
      throw GraphClientConfig.translateException(
          operation, input, result.exception!);
    }

    var rawData = result.data!["create${entityName.plural}"]
        ["${entityName.artifactPlural}"][0];
    assert(rawData is Map, "Result of create$entityName must be a Map");
    return (rawData as Map).cast();
  }

  Future<T> createEntity<T>({
    required String entityName,
    required GraphObject input,
  }) async {
    final res = await createEntityJson(entityName: entityName, input: input);
    return this._serializer.read<T>(
          res,
          typeName: entityName,
          isNullable: false,
        );
  }

  Future<T> updateEntity<T>({
    required String entityName,
    required String id,
    required GraphObject update,
  }) async {
    final res =
        await updateEntityJson(entityName: entityName, id: id, update: update);
    return this._serializer.read<T>(
          res,
          typeName: entityName,
          isNullable: false,
        );
  }

  Future<GraphObject> updateEntityJson({
    required String entityName,
    required String id,
    required GraphObject update,
  }) async {
    var operation = _resolver.getOperation(entityName, 'update');
    var variables = {"id": id, "update": update};
    var result = await this._client().mutate(MutationOptions(
          document: operation!.operation,
          operationName: operation.operationName,
          variables: variables,
        ));

    if (result.hasException) {
      throw GraphClientConfig.translateException(
          operation, variables, result.exception!);
    }

    try {
      var rawData = result.data!["update${entityName.plural}"]
          ["${entityName.artifactPlural}"][0];
      assert(rawData is Map, "Result of create$entityName must be a Map");
      return (rawData as Map).cast();
    } catch (e) {
      print("Error: $e");
      print(e);
      rethrow;
    }
  }

  Future<List<T>> loadRelatedList<T>({
    required String entityName,
    required String entityId,
    required String fieldName,
    required String relatedType,
    String? queryName,
    bool isNullable = false,
    bool isJoinType = false,
    Map<String, Object?>? fixedWhere,
    List<QueryParameter> args = const [],
  }) async {
    final raw = await this.loadRelatedJson(
      entityName: entityName,
      entityId: entityId,
      fieldName: fieldName,
      relatedType: relatedType,
      fixedWhere: fixedWhere,
      queryName: queryName,
      isNullable: isNullable,
      isJoinType: isJoinType,
      args: args,
    );
    return this._serializer.readList<T>(
          raw,
          typeName: relatedType,
          isNullable: isNullable,
        );
  }

  Future<List<JoinRecord<T, Entity, D>>>
      loadJoinList<T extends Entity, D extends JoinRecordData>({
    required String entityName,
    required String entityId,
    required String fieldName,
    String? queryName,
    bool isNullable = false,
    Map<String, Object?>? fixedWhere,
    List<QueryParameter> args = const [],
  }) async {
    var relatedType = "${entityName}${singularize(fieldName).capitalize()}";
    final raw = await this.loadRelatedJson(
        entityName: entityName,
        entityId: entityId,
        fieldName: "${fieldName}Connection",
        relatedType: relatedType,
        fixedWhere: fixedWhere,
        args: args,
        queryName: queryName,
        isNullable: isNullable,
        isJoinType: true);
    return this._serializer.readList<JoinRecord<T, Entity, D>>(
          raw,
          typeName: relatedType,
          isNullable: isNullable,
        );
  }

  Future<JoinRecord<T, Entity, D>?>
      loadJoin<T extends Entity, D extends JoinRecordData>({
    required String entityName,
    required String entityId,
    required String fieldName,
    String? queryName,
    bool isNullable = false,
    bool isJoinType = false,
    Map<String, Object?>? fixedWhere,
    List<QueryParameter> args = const [],
  }) async {
    var relatedType = "${entityName}${singularize(fieldName).capitalize()}";
    final raw = await this.loadRelatedJson(
        entityName: entityName,
        entityId: entityId,
        fieldName: "${fieldName}Connection",
        relatedType: relatedType,
        fixedWhere: fixedWhere,
        queryName: queryName,
        isNullable: isNullable,
        args: args,
        isJoinType: isJoinType);
    return this._serializer.read<JoinRecord<T, Entity, D>>(
          raw,
          typeName: relatedType,
          isNullable: isNullable,
        );
  }

  Future<T> loadRelated<T>({
    required String entityName,
    required String entityId,
    required String fieldName,
    required String relatedType,
    String? queryName,
    bool? isNullable,
    bool isJoinType = false,
    Map<String, Object?>? fixedWhere,
    List<QueryParameter> args = const [],
  }) async {
    isNullable ??= "$T".endsWith("?");
    final raw = await this.loadRelatedJson(
        entityName: entityName,
        entityId: entityId,
        fieldName: fieldName,
        relatedType: relatedType,
        fixedWhere: fixedWhere,
        args: args,
        queryName: queryName,
        isNullable: isNullable,
        isJoinType: isJoinType);
    return this._serializer.read<T>(
          raw,
          typeName: relatedType,
          isNullable: isNullable,
        );
  }

  Future<T?> load<T>({required String entityName, required String id}) async {
    final raw = await loadJson(entityName: entityName, id: id);
    return this
        ._serializer
        .read<T?>(raw, typeName: entityName, isNullable: true);
  }

  Future<Object?> loadJson(
      {required String entityName, required String id}) async {
    var operation = _resolver.getOperation(entityName, 'load')!;
    var result = await this._client().mutate(MutationOptions(
          document: operation.operation,
          operationName: operation.operationName,
          variables: {"id": id},
        ));

    if (result.hasException) {
      throw GraphClientConfig.translateException(
          operation, id, result.exception!);
    }
    var list = result.data!["${entityName.artifactPlural}"] as List?;
    return list?.firstOr();
  }
}

extension StringEntityNameExt on String {
  String get artifactPlural {
    return plural.uncapitalize();
  }

  String get plural {
    return pluralize(this);
  }
}
