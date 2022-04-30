import 'package:collection_diff/collection_diff.dart';
import 'package:dartxx/dartxx.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inflection3/inflection3.dart';
import 'package:sunny_graphql/fragments.dart';
import 'package:sunny_graphql/meta.dart';
import 'package:sunny_sdk_core/api_exports.dart';
import 'package:sunny_sdk_core/mverse.dart';
import 'package:sunny_sdk_core/mverse/m_base_model.dart';

import 'graph_client_config.dart';

extension NullableObjectGraphQLExt on Object? {
  Map<String, Object?>? asObjectMap() => this as Map<String, Object?>?;
}

extension NonNullObjectGraphQLExt on Object {
  Map<String, Object?> asObjectMap() => this as Map<String, Object?>;

  Object withoutKey(String key) {
    this.asObjectMap().remove(key);
    return this;
  }
}

abstract class BaseGraphInput
    with MBaseModelMixin, HasGraphMeta
    implements GraphInput {
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

mixin JoinTypeMixin<N extends BaseSunnyEntity> {
  N? get node;

  String? get id => node?.mkey?.mxid;

  Object? toJson();
}

abstract class BaseSunnyEntity
    with MBaseModelMixin, DiffDelegateMixin, HasGraphMeta {
  String? get id;

  // Map<String, dynamic> toMap();

  MKey? get mkey {
    return id == null ? null : MKey.fromType(mtype, id!);
  }

  Map<String, Object?> toMap();

  Object? toJson();

  dynamic operator [](key) => throw "Not implemented";

  void operator []=(String key, value) => throw "Not implemented";

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
    return GraphClientConfig.read(toMap(),
        typeName: mtype.artifactId!.capitalize(), isNullable: false);
  }

  void takeFrom(dynamic source) {
    throw "Not implemented";
  }

  void takeFromMap(Map<String, dynamic>? map, {bool copyEntries = true}) {
    map?.forEach((key, value) {
      this[key] = value;
    });
  }

  @override
  dynamic get diffKey => id;

  @override
  dynamic get diffSource => toJson();
}

abstract class GraphQueryResolver {
  DocumentNode? getQuery(String name);

  GraphOperation? getOperation(String entityName, String op);

  DocumentNode getOrCreateQuery(String name, String type, String gql());
  DocumentNode getOrBuildQuery(
      String name, String type, OperationDefinitionNode gql());
}

class Neo4JGraphQueryResolver
    with FragmentManager
    implements GraphQueryResolver {
  final _queries = <String, GraphOperation>{};

  @override
  GraphOperation? getOperation(String entityName, String op) {
    var queryName = '${op.uncapitalize()}${entityName}';
    return _queries.putIfAbsent(queryName, () {
      switch (op) {
        case 'create':
          return _buildCreateQuery(entityName, queryName);
        case 'update':
          return _buildUpdateQuery(entityName, queryName);
        case 'delete':
          return _buildDeleteQuery(entityName, queryName);
        case 'list':
          return buildListQuery(entityName, queryName);
        case 'load':
          return _buildLoadQuery(entityName, queryName);
        case 'count':
          return _buildCountQuery(entityName, queryName);
        default:
          throw 'No query could be created';
      }
    });
  }

  GraphOperation _buildCreateQuery(String entityName, String queryName) {
    final plural = pluralize(entityName);
    return GraphOperation(queryName, GraphOperations.create, this.operation("""
    mutation $queryName(\$input: ${entityName}CreateInput!) {
      create${plural}(input: [\$input]) {
        ${plural.uncapitalize()} {
          ...${entityName}Fragment
        }
      }
    }
    """));
  }

  GraphOperation _buildUpdateQuery(String entityName, String queryName) {
    final plural = pluralize(entityName);
    final pluralArtifact = plural.uncapitalize();
    return GraphOperation(queryName, GraphOperations.update, this.operation("""
    mutation $queryName(\$id: ID!, \$update: ${entityName}UpdateInput!) {
        update${plural}(where: {id: \$id}, update: \$update) {
          $pluralArtifact {
            ...${entityName}Fragment
          }
        }
    }
    """));
  }

  GraphOperation _buildDeleteQuery(String entityName, String queryName) {
    final plural = pluralize(entityName);
    return GraphOperation(
      queryName,
      GraphOperations.delete,
      this.operation("""
    
    mutation $queryName(\$id: ID!) {
      delete$plural(where: {id: \$id}) {
        nodesDeleted
      }
    }
    """),
    );
  }

  OperationDefinitionNode buildListRelatedQuery({
    required String thisType,
    required String relatedType,
    required String fieldName,
    required String queryName,
    Map<String, Object?>? where,
  }) {
    final rootWhere = {
      'id': VariableNode(name: NameNode(value: 'id')),
    };

    final artifactPlural = pluralize(thisType.uncapitalize());
    return OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: queryName),
      variableDefinitions: [
        VariableDefinitionNode(
          defaultValue: DefaultValueNode(value: null),
          variable: VariableNode(name: NameNode(value: "id")),
          type: NamedTypeNode(
            name: NameNode(value: "ID"),
            isNonNull: true,
          ),
        )
      ],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: artifactPlural),
            arguments: [
              ArgumentNode(
                  name: NameNode(value: "where"),
                  value: rootWhere.toValueNode()),
            ],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: fieldName),
                  arguments: [
                    if (where?.isNotEmpty == true)
                      ArgumentNode(
                        name: NameNode(value: "where"),
                        value: where.toValueNode(),
                      ),
                  ],
                  selectionSet: SelectionSetNode(
                    selections: [
                      FragmentSpreadNode(
                          name: NameNode(value: '${relatedType}Fragment')),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  GraphOperation buildListQuery(String entityName, String queryName) {
    final plural = pluralize(entityName);
    return GraphOperation(queryName, GraphOperations.list, this.operation("""
    query $queryName(\$where: ${entityName}Where!) {
      ${plural.uncapitalize()}(where: \$where) {
        ...${entityName}Fragment
      }
    }
    """));
  }

  GraphOperation _buildLoadQuery(String entityName, String queryName) {
    final plural = pluralize(entityName);
    return GraphOperation(queryName, GraphOperations.load, this.operation("""
    query $queryName(\$id: ID!) {
      ${plural.uncapitalize()}(where: {id: \$id}) {
        ...${entityName}Fragment
      }
    }
    """));
  }

  GraphOperation _buildCountQuery(String entityName, String queryName) {
    final plural = pluralize(entityName);
    return GraphOperation(queryName, GraphOperations.count, this.operation("""
    query $queryName {
      ${plural.uncapitalize()}Count
    }
    """));
  }

  DocumentNode operation(String operation) {
    final document = gql(operation);
    return DocumentNode(definitions: [
      ...document.definitions,
      ...getFragmentsForOperation(document.firstOp),
    ]);
  }

  DocumentNode operationFromNode(OperationDefinitionNode operation) {
    return DocumentNode(definitions: [
      operation,
      ...getFragmentsForOperation(operation),
    ]);
  }

  @override
  DocumentNode? getQuery(String name) {
    return _queries[name]?.operation;
  }

  @override
  DocumentNode getOrCreateQuery(
      String name, String type, String Function() generateQuery) {
    return _queries.putIfAbsent(name, () {
      final document = this.operation(generateQuery());
      return GraphOperation(name, type, document);
    }).operation;
  }

  @override
  DocumentNode getOrBuildQuery(String name, String type,
      OperationDefinitionNode Function() generateQuery) {
    return _queries.putIfAbsent(name, () {
      final document = this.operationFromNode(generateQuery());
      return GraphOperation(name, type, document);
    }).operation;
  }
}

class GraphOperations {
  static const create = 'create';
  static const update = 'update';
  static const delete = 'delete';
  static const load = 'load';
  static const list = 'list';
  static const count = 'count';
  static const listRelated = 'listRelated';

  GraphOperations._();
}

class GraphOperation with EquatableMixin {
  final String operationType;
  final DocumentNode operation;
  final String operationName;

  GraphOperation(
    this.operationName,
    this.operationType,
    this.operation,
  );

  @override
  List<Object> get props => [operation, operationName, operationType];

  bool get isMutate {
    switch (this.operationType) {
      case GraphOperations.delete:
      case GraphOperations.update:
      case GraphOperations.create:
        return true;
      default:
        return false;
    }
  }
}

extension DocumentNodeOperationGetter on DocumentNode {
  OperationDefinitionNode get firstOp =>
      definitions.whereType<OperationDefinitionNode>().first;
}

extension _ObjectToValueNode on Object? {
  ValueNode toValueNode() {
    final self = this;
    if (self == null) return const NullValueNode();
    if (self is String) {
      return StringValueNode(value: self, isBlock: false);
    } else if (self is int) {
      return IntValueNode(value: self.toString());
    } else if (self is num) {
      return FloatValueNode(value: self.toString());
    } else if (self is Iterable<Object?>) {
      return ListValueNode(values: self.map((e) => e.toValueNode()).toList());
    } else if (self is Map<Object?, Object?>) {
      return ObjectValueNode(
          fields: self.entries
              .map((entry) => ObjectFieldNode(
                    name: NameNode(value: entry.key.toString()),
                    value: entry.value.toValueNode(),
                  ))
              .toList());
    } else if (self is ValueNode) {
      return self;
    } else {
      throw "Don't know how to create value node from ${this.runtimeType}";
    }
  }
}
