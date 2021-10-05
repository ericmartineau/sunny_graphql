import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:logging/logging.dart';
import 'package:sunny_graphql_generator/code_builder.dart';
import 'package:sunny_graphql_generator/graphql_neo4j_scanner.dart';
import 'package:sunny_graphql_generator/graphql_scanner_code_builder.dart';

import 'graphql_entity.dart';
import 'shared_code_builders.dart';
import 'shared.dart';

final _log = Logger('graphql_generator');
final IdParameter = Parameter(
  (p) => p
    ..name = 'id'
    ..type = refer('String'),
);
const notImplemented = Code('throw "Not implemented";');

CodeBuilder buildNeo4jCode(GraphQLNeo4Model model) {
  _log.info('Writing Subqueries');
  var code = CodeBuilder();
  model.model.addAllModels(
    code,
    inputGenerator: (c, name, fields, isAbstract) {
      c.implements.add(refer('GraphInput'));
    },
    extraGenerator: (c, name, fields, isAbstract) {
      c.extend = refer('BaseSunnyEntity');
      c.fields.add(Field((f) => f
        ..name = 'ref'
        ..static = true
        ..modifier = FieldModifier.constant
        ..assignment =
            Code('MSchemaRef("mverse", "${model.moduleName.uncapitalize()}", "${name.uncapitalize()}", "1.0.0", "mvext")')));
      c.methods.add(Method((f) => f
        ..name = 'mtype'
        ..type = MethodType.getter
        ..returns = refer('MSchemaRef')
        ..body = Code('return ref;')));
    },
  );

  model.entities.forEach((objName, entity) {
    if (entity.ops.isEmpty) return;

    code += [
      """
  final ${entity.name}CreateOp = gql(r\"\"\"
    mutation create${entity.name}(\$input: ${entity.name}CreateInput!) {
      create${entity.name}s(input: [\$input]) {
        ${entity.name.uncapitalize()}s {
          ...${entity.name}Fragment,
        }
      }
    }
  \"\"\");""",
      "",
      """
  final ${entity.name}UpdateOp = gql(r\"\"\"
    mutation update${entity.name}(\$id: ID!, 
                                  \$update: ${entity.name}UpdateInput!
                                  \$create: ${entity.name}RelationInput,
                                  \$connect: ${entity.name}ConnectInput,
                                  \$disconnect: ${entity.name}DisconnectInput,
                                  \$delete: ${entity.name}DeleteInput,
                                  ) {
      update${entity.name}s(where: {id: \$id}, update: \$update, create: \$create, 
                            connect: \$connect, disconnect: \$disconnect, delete: \$delete) {
        ${entity.name.uncapitalize()}s {
          ...${entity.name}Fragment,
        }
      }
    }
  \"\"\");""",
      "",
      """
  final ${entity.name}DeleteOp = gql(r\"\"\"
    mutation delete${entity.name}(\$id: ID!) {
      delete${entity.name}s(where: {id: \$id}) {
        nodesDeleted
      }
    }
  \"\"\");""",
      "",
      """
  final ${entity.name}ListOp = gql(r\"\"\"
    query list${entity.name}(\$where: ${entity.name}Where!) {
      ${entity.name.uncapitalize()}s(where: \$where) {
        ...${entity.name}Fragment
      }
    }
  \"\"\");""",
      "",
      """
  final ${entity.name}LoadOp = gql(r\"\"\"
    query load${entity.name}(\$id: ID!) {
      ${entity.name.uncapitalize()}s(where: {id: \$id}) {
        ...${entity.name}Fragment
      }
    }
  \"\"\");""",
      "",
      """
  final ${entity.name}CountOp = gql(r\"\"\"
    query count${entity.name}s {
      ${entity.name.uncapitalize()}sCount
    }
  \"\"\");""",
    ];
    code += Class((c) => c
      ..name = '${objName.capitalize()}Api'
      ..extend =
          refer("GraphApi<${objName.capitalize()}, ${objName.capitalize()}CreateInput, ${objName.capitalize()}UpdateInput>")
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
          ..type = refer('GraphQueryResolver')
          ..modifier = FieldModifier.final$),
        Field((f) => f
          ..name = '_client'
          ..type = refer('GraphQLClientGetter')
          ..modifier = FieldModifier.final$),
      ])
      ..methods.addAll([
        Method((m) => m
          ..type = MethodType.getter
          ..name = 'mtype'
          ..returns = refer('MSchemaRef')
          ..body = Code('return ${objName.capitalize()}.ref;')),
        Method((m) => m
          ..annotations.add(refer('override'))
          ..name = 'client'
          ..returns = refer('GraphQLClient')
          ..body = Code('return this._client();')),
        // for (var op in entity.ops) ...buildOperationMethod(model.model, entity, subqueries, op),
        for (var sub in entity.fields.lazy)
          Method(
            (m) => m
              ..name = 'load${sub.name.capitalize()}For${entity.name}'
              ..returns = refer(sub.nullableDartTypeName).future()
              ..requiredParameters.add(IdParameter)
              ..body = Code(
                  'return this.loadRelated${sub.isList ? 'List' : ''}(id: id, relatedType: "${sub.typeNode.toRawType()}", isNullable: ${!sub.isNonNull}, field: "${sub.name}", '
                  'fragments: DocumentNodes([${[...model.model.fragmentDepends[sub.typeNode.toRawType()]].join(', ')}],),);'),
          ),
      ]));
  });

  buildSerializer(model.model, code);
  buildResolver(model, code);
  return code;
}

buildResolver(GraphQLNeo4Model neo, CodeBuilder code) {
  final model = neo.model;
  CodeBuilder cases = CodeBuilder();
  for (var entity in neo.entities.values) {
    getFragments(String op) {
      return 'DocumentNodes([${['${entity.name}${op.capitalize()}Op', ...model.fragmentDepends[entity.name]].join(', ')}])';
    }

    entity.ops.forEach((element) {
      switch (element) {
        case GraphOpType.create:
          cases += "    case '${entity.name}CreateOp': return ${getFragments('create')};";
          break;
        case GraphOpType.update:
          cases += "    case '${entity.name}UpdateOp': return ${getFragments('update')};";
          break;
        case GraphOpType.delete:
          cases += "    case '${entity.name}DeleteOp': return ${entity.name}DeleteOp;";
          break;
        case GraphOpType.list:
          cases += "    case '${entity.name}ListOp': return ${getFragments('list')};";
          cases += "    case '${entity.name}LoadOp': return ${getFragments('load')};";
          break;
        case GraphOpType.count:
          cases += "    case '${entity.name}CountOp': return ${entity.name}CountOp;";
          break;
      }
    });
  }
  code += Class(
    (c) => c
      ..name = '${neo.moduleName.capitalize()}QueryResolver'
      ..extend = refer('GraphQueryResolver')
      ..methods.add(
        Method(
          (f) => f
            ..name = 'getQuery'
            ..returns = refer('DocumentNode?')
            ..requiredParameters.add(Parameter((p) => p
              ..name = 'queryName'
              ..type = refer('String')))
            ..body = Code("""
      switch(queryName) {
        ${cases.toString()}
        default: return null;
      }
      """),
        ),
      ),
  );
}
