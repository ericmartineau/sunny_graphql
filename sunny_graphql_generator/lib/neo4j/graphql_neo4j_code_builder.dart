import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:logging/logging.dart';
import 'package:sunny_graphql_generator/code_builder.dart';
import 'package:sunny_graphql_generator/graphql_scanner_code_builder.dart';
import 'package:sunny_graphql_generator/neo4j/graphql_neo4j_scanner.dart';

import '../shared.dart';
import '../shared_code_builders.dart';

final _log = Logger('graphql_generator');
final IdParameter = Parameter(
  (p) => p
    ..name = 'id'
    ..type = refer('String'),
);
const notImplemented = Code('throw "Not implemented";');

CodeBuilder buildNeo4jCode(GraphQLNeo4Model model) {
  var code = CodeBuilder();
  model.model.addAllModels(
    code,
    inputGenerator: (c, name, fields, isAbstract) {
      final typeName =
          name.replaceAll("CreateInput", "").replaceAll("UpdateInput", "");
      c.extend = refer('BaseGraphInput');
      c.methods.add(Method((f) => f
        ..overridden()
        ..returns = refer('${typeName}Meta')
        ..name = 'meta'
        ..type = MethodType.getter
        ..body = Code('return ${typeName}Meta.instance;')));
    },
    extraGenerator: (c, name, fields, isAbstract) {
      c.extend = refer('BaseSunnyEntity');
      c.methods.add(Method((f) => f
        ..name = 'metadata'
        ..static = true
        ..type = MethodType.getter
        ..returns = refer('${name}Meta')
        ..body = refer('${name}Meta').property('instance').code));
      c.methods.add(Method((f) => f
        ..name = 'ref'
        ..static = true
        ..type = MethodType.getter
        ..returns = refer('MSchemaRef')
        ..body =
            refer('${name}Meta').property('instance').property('mtype').code));

      c.methods.add(Method((f) => f
        ..overridden()
        ..returns = refer('${name}Meta')
        ..name = 'meta'
        ..type = MethodType.getter
        ..body = Code('return ${name}Meta.instance;')));
    },
  );

  model.entities.forEach((objName, entity) {
    if (entity.ops.isEmpty) return;

    code += Class((c) => c
      ..name = '${objName.capitalize()}Api'
      ..extend = refer('${objName.capitalize()}ApiBase')
      ..constructors.add(Constructor((c) => c
        ..requiredParameters.addAll([
          Parameter((p) => p
            ..name = "_client"
            ..toThis = true),
          Parameter((p) => p
            ..name = "resolver"
            ..toThis = true),
          Parameter((p) => p
            ..name = "serializer"
            ..toThis = true),
          Parameter((p) => p
            ..name = "eventService"
            ..toThis = true),
        ])))
      ..fields.addAll([
        Field((f) => f
          ..annotations.add(refer('override'))
          ..name = 'serializer'
          ..type = refer('GraphSerializer')
          ..modifier = FieldModifier.final$),
        Field((f) => f
          ..name = 'resolver'
          ..annotations.add(refer('override'))
          ..type = refer('Neo4JGraphQueryResolver')
          ..modifier = FieldModifier.final$),
        Field((f) => f
          ..name = '_client'
          ..type = refer('GraphQLClientGetter')
          ..modifier = FieldModifier.final$),
        Field((f) => f
          ..name = 'eventService'
          ..type = refer('RecordEventService')
          ..modifier = FieldModifier.final$),
      ])
      ..methods.addAll([
        Method((f) => f
          ..overridden()
          ..name = 'meta'
          ..type = MethodType.getter
          ..returns = refer('${objName.capitalize()}Meta')
          ..body =
              refer('${objName.capitalize()}Meta').property('instance').code),
        Method((m) => m
          ..annotations.add(refer('override'))
          ..name = 'client'
          ..returns = refer('GraphQLClient')
          ..body = Code('return this._client();')),
        // for (var op in entity.ops) ...buildOperationMethod(model.model, entity, subqueries, op),
        for (var sub in entity.fields.lazy)
          if (sub.relationship?.propsType == null)
            Method(
              (m) => m
                ..name = 'load${sub.name.capitalize()}ForRecord'
                ..returns = refer(sub.nullableDartTypeName).future()
                ..requiredParameters.add(IdParameter)
                ..body = Code(
                    'return this.loadRelated${sub.isList ? 'List' : ''}(id: id, relatedType: "${sub.typeNode.toRawType()}", isNullable: ${!sub.isNonNull}, field: "${sub.name}", isJoinType: false,);'),
            )
          else ...[
            // Method(
            //   (m) => m
            //     ..name = 'load${sub.relationship?.propsType}ForRecord'
            //     ..returns = refer(sub.isList ? 'List<${sub.relationship?.joinTypeName}>' : sub.nullableDartTypeName).future()
            //     ..requiredParameters.add(IdParameter)
            //     ..body = Code(
            //         'return this.loadRelated${sub.isList ? 'List' : ''}(id: id, relatedType: "${sub.relationship?.joinTypeName}", isNullable: ${!sub.isNonNull}, field: "${sub.name}Connection",);'),
            // ),
            Method(
              (m) => m
                ..name = 'load${sub.name.capitalize()}ForRecord'
                ..returns = refer(sub.isList
                        ? 'List<${sub.joinRecordType}>'
                        : sub.nullableDartTypeName)
                    .future()
                ..requiredParameters.add(IdParameter)
                ..body = Code(
                    'return this.loadRelated${sub.isList ? 'List' : ''}(id: id, relatedType: "${sub.joinRecordType}", isNullable: ${!sub.isNonNull}, field: "${sub.name}Connection", isJoinType: true,);'),
            ),
          ],
      ]));
  });
  buildSerializer(model.model, code);
  buildResolver(model, code);
  return code;
}

buildResolver(GraphQLNeo4Model neo, CodeBuilder code) {
  final model = neo.model;

  code += Class((c) => c
    ..name = '${neo.moduleName.capitalize()}QueryResolver'
    ..extend = refer('Neo4JGraphQueryResolver')
    ..constructors.add(
      Constructor(
        (c) => c
          ..body = CodeBuilder.lines(
            [
              'this.initializeFragments(',
              '  fragments: [${{
                ...model.fragments.keys.map((field) => "$field"),
                ...neo.externalFragments,
              }.join(',\n      ')}',
              '  ],',
              ');',
            ],
          ),
      ),
    ));
}
