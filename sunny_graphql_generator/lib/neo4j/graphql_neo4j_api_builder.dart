import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:logging/logging.dart';
import 'package:sunny_graphql_generator/code_builder.dart';
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

CodeBuilder buildNeo4jCodeApi(GraphQLNeo4Model model) {
  _log.info('Writing Subqueries');
  var code = CodeBuilder();
  model.model.addAllModelApis(
    code,
    inputGenerator: (c, name, fields, isAbstract) {
      c.extend = refer('BaseGraphInput');
    },
    extraGenerator: (c, name, fields, isAbstract) {
      c.extend = refer('BaseSunnyEntity');

      c.fields.add(Field((f) => f
        ..name = 'meta'
        ..static = true
        ..modifier = FieldModifier.constant
        ..assignment = Code('${name}Meta.instance')));
    },
  );

  model.entities.forEach((objName, entity) {
    if (entity.ops.isEmpty) return;

    code += Class((c) => c
      ..name = '${objName.capitalize()}ApiBase'
      ..abstract = true
      ..extend = refer(
          "GraphApi<${objName.capitalize()}, ${objName.capitalize()}CreateInput, ${objName.capitalize()}UpdateInput>")
      ..mixins.addAll(entity.serviceMixins.map(refer))
      ..implements.addAll(entity.serviceInterfaces.map(refer))
      ..methods.addAll([
        // for (var op in entity.ops) ...buildOperationMethod(model.model, entity, subqueries, op),
        for (var sub in entity.fields.lazy)
          if (sub.relationship?.propsType == null)
            Method(
              (m) => m
                ..name = 'load${sub.name.capitalize()}ForRecord'
                ..returns = refer(sub.nullableDartTypeName).future()
                ..requiredParameters.add(IdParameter),
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
            Method((m) => m
              ..name = 'load${sub.name.capitalize()}ForRecord'
              ..returns = refer(sub.isList
                      ? 'List<${sub.joinRecordType}>'
                      : sub.nullableDartTypeName)
                  .future()
              ..requiredParameters.add(IdParameter)),
          ],
      ]));
  });
  return code;
}
