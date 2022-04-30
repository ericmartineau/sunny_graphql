import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:logging/logging.dart';
import 'package:sunny_graphql_generator/code_builder.dart';
import 'package:sunny_graphql_generator/neo4j/graphql_neo4j_scanner.dart';

import '../shared.dart';

final _log = Logger('graphql_generator');
final IdParameter = Parameter(
  (p) => p
    ..name = 'id'
    ..type = refer('String'),
);
const notImplemented = Code('throw "Not implemented";');

CodeBuilder buildNeo4jCodeMeta(GraphQLNeo4Model model) {
  var code = CodeBuilder();
  model.model.objectTypes.forEach((entityName, def) {
    /// Add paths and fields?
    code += [
      'class ${def.name.value}Fields {',
      '  const ${def.name.value}Fields._();',
      for (var field in def.fields.map((f) =>
          FieldDefinition.ofField(model.model, f, entityName: def.name.value)))
        '  static const ${field.name} = "${field.name}";',
      '  static const values = {',
      for (var field in def.fields) '      ${field.name.value},',
      '  };',
      '}',
    ];

    /// Add paths and fields?
    code += [
      'class ${def.name.value}Paths  {',
      '  const ${def.name.value}Paths._();',
      for (var field in def.fields.map((f) =>
          FieldDefinition.ofField(model.model, f, entityName: def.name.value)))
        '  static const ${field.name} = JsonPath<${field.nullableDartTypeName}>.single("${field.name}");',
      '  static const values = [',
      for (var field in def.fields) '      ${field.name.value},',
      '  ];',
      '}',
    ];
  });
  model.model.objectTypes.forEach((entityName, def) {
    code += Class((build) => build
      ..name = '${def.name.value}Meta'
      ..extend = refer('EntityMeta')
      ..fields.add(
        Field((fld) => fld
              ..name = 'instance'
              ..static = true
              ..modifier = FieldModifier.constant
              ..assignment = Code("${def.name.value}Meta._()")
            // '  static const instance = ',
            ),
      )
      ..constructors.add(Constructor((ctr) => ctr
        ..name = "_"
        ..constant = true
        ..initializers.add(refer('super').call([
          refer('${def.name.value}Fields').property('values'),
          refer('${def.name.value}Paths').property('values'),
          refer('MSchemaRef').constInstance([
            'mverse',
            '${model.moduleName.uncapitalize()}',
            '${def.name.value.uncapitalize()}',
            '1.0.0',
            'mvext',
          ].map(literal)),
        ]).code))));
  });
  return code;
}
