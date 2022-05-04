import 'package:dartxx/dartxx.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inflection3/inflection3.dart';
import 'package:sunny_graphql/meta.dart';
import 'package:sunny_graphql/neo4j_graph_client.dart';
import 'package:sunny_graphql/sunny_graphql_models.dart';
import 'package:sunny_sdk_core/api_exports.dart';
import 'package:sunny_sdk_core/data/record_events.dart';

import 'graph_client_config.dart';
import 'graph_client_serialization.dart';

class EntityCreatedEvent<T extends BaseSunnyEntity, C extends GraphInput> {
  final String createdId;
  final C input;
  final T created;

  const EntityCreatedEvent({
    required this.createdId,
    required this.input,
    required this.created,
  });
}

class EntityUpdatedEvent<T extends BaseSunnyEntity, U extends GraphInput> {
  final String createdId;
  final U input;
  final T updated;

  const EntityUpdatedEvent({
    required this.createdId,
    required this.input,
    required this.updated,
  });
}

class EntityDeletedEvent<T extends BaseSunnyEntity> {
  final String recordId;

  const EntityDeletedEvent(this.recordId);
}

abstract class GraphApi<T extends BaseSunnyEntity, C extends GraphInput,
    U extends GraphInput> {
  GraphQLClient client();

  Neo4JGraphQLClient neo4JClient() {
    return Neo4JGraphQLClient(() => client(), resolver, serializer);
  }

  EntityMeta get meta;

  RecordEventService get eventService;

  GraphSerializer get serializer;

  Neo4JGraphQueryResolver get resolver;

  MSchemaRef get mtype => meta.mtype;

  String get entityName => mtype.artifactId!.capitalize();

  String get entityPlural => pluralize(entityName);

  String get artifactId => mtype.artifactId!;

  String get artifactPlural => pluralize(artifactId);

  Future<T> create(C input) async {
    final created = await neo4JClient()
        .createEntity<T>(entityName: entityName, input: input.toJson()!);
    eventService.publish(
        EntityCreatedEvent(
            createdId: created.id!, input: input, created: created),
        RecordEventType.create);
    return created;
  }

  Future<T> update(String id, U input) async {
    final result = await neo4JClient().updateEntity<T>(
        entityName: entityName, id: id, update: input.toJson()!);
    eventService.publish(
        EntityUpdatedEvent(createdId: id, input: input, updated: result),
        RecordEventType.update);
    return result;
  }

  Future<int> delete(String id) async {
    final operation = resolver.getOperation(entityName, 'delete')!;
    var variables = {"id": id};
    var result = await this.client().queryManager.mutate(
          MutationOptions(
              document: operation.operation,
              operationName: operation.operationName,
              variables: variables),
        );

    if (result.hasException) {
      throw GraphClientConfig.translateException(
          operation, variables, result.exception!);
    }
    eventService.publish(EntityDeletedEvent<T>(id), RecordEventType.delete);

    return result.data!["delete${entityPlural}"]['nodesDeleted'] as int;
  }

  Future<List<T>> list([Object filters = const {}]) async {
    var operation = resolver.getOperation(entityName, 'list')!;
    var result = await this.client().queryManager.mutate(MutationOptions(
          document: operation.operation,
          operationName: operation.operationName,
          variables: {"where": filters},
        ));

    if (result.hasException) {
      throw GraphClientConfig.translateException(
          operation, filters, result.exception!);
    }

    return this.serializer.readList(
          result.data![entityPlural.uncapitalize()],
          typeName: entityName,
          isNullable: false,
        );
  }

  Future<T?> load(String id) =>
      neo4JClient().load<T>(entityName: entityName, id: id);

  Future<T> getOrCreate(String id, {required C create()}) async {
    final existing = await load(id);
    return existing ?? await this.create(create());
  }

  Future<T> get(String id) async {
    final record = await load(id);
    return record ?? nullPointer('No $entityName record for $id');
  }

  Future<double> count() async {
    var operation = resolver.getOperation(entityName, 'count')!;
    var result = await this.client().queryManager.mutate(MutationOptions(
        document: operation.operation,
        operationName: operation.operationName,
        variables: {}));

    if (result.hasException) {
      throw GraphClientConfig.translateException(
          operation, null, result.exception!);
    }

    return result.data!["${artifactPlural}Count"] as double;
  }

  Future<T> loadRelated<T>({
    required String id,
    required String relatedType,
    required String field,
    required bool isNullable,
    required bool isJoinType,
    Map<String, Object?>? where,
    String? queryName,
  }) =>
      neo4JClient().loadRelated<T>(
        entityId: id,
        fieldName: field,
        relatedType: relatedType,
        isJoinType: isJoinType,
        isNullable: isNullable,
        queryName: queryName,
        fixedWhere: where,
        entityName: this.entityName,
      );

  Future<List<T>> loadRelatedList<T>({
    required String id,
    required String relatedType,
    required bool isNullable,
    required String field,
    required bool isJoinType,
    Map<String, Object?>? where,
    String? queryName,
  }) =>
      neo4JClient().loadRelatedList<T>(
        entityId: id,
        fieldName: field,
        relatedType: relatedType,
        entityName: this.entityName,
        fixedWhere: where,
        isJoinType: isJoinType,
      );
}
