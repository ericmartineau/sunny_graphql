import 'package:code_builder/code_builder.dart';
import 'package:gql/ast.dart';
import 'package:sunny_graphql_generator/code_builder.dart';

import '../shared.dart';
import '../shared_code_builders.dart';

void buildNonInputClass(
  ClassBuilder classDef, {
  required String name,
  required bool isEntity,
  required Iterable<FieldDefinition> sourceFields,
  required List<DirectiveNode> directives,
}) {
  classDef
    ..implements.addAll([
      if (isEntity) refer('Entity'),
    ])
    ..constructors.addAll(
      [
        Constructor(
          (ctr) => ctr
            ..optionalParameters.addAll([
              for (var field in sourceFields)
                if (field.isList)
                  field.toParameter(
                    isThis: false,
                    forceOptional: true,
                  )
                else
                  field.toParameter(isThis: true),
            ])
            ..initializers.addAll([
              for (var field in sourceFields)
                if (field.isList) Code("${field.name} = ${field.name} ?? []"),
            ])
            ..body = CodeBuilder.lines([
              for (var field in sourceFields)
                if (field.relationship?.propsType != null) 'this.${field.mappedName}.self = this;',
            ]),
        ),
        Constructor(
          (ctr) => ctr
            ..name = 'fromJson'
            ..factory = true
            ..requiredParameters.add(Parameter((p) => p
              ..name = "json"
              ..type = refer('dynamic')
              ..named = false))
            ..body = refer(name).call(
              [],
              {
                for (var field in sourceFields) field.mappedName: field.readExpression(),
              },
            ).code,
        ),
        Constructor(
          (ctr) => ctr
            ..name = 'fromMap'
            ..requiredParameters.add(Parameter((p) => p
              ..name = "map"
              ..type = refer('Map<String, dynamic>')
              ..named = false))
            ..initializers.addAll([
              for (var field in sourceFields) Code("${field.mappedName} = map.get('${field.mappedName}')"),
            ]),
        ),
      ],
    )
    ..methods.addAll([
      Method((m) => m
        ..name = 'toMap'
        ..overridden()
        ..returns = refer('JsonObject')
        ..body = literalMap({
          for (var field in sourceFields) literal(field.name): refer('this').property(field.name),
        }).code),
      Method((toJsonMethod) {
        var toJsonExpression = '{';
        for (var field in sourceFields) {
          toJsonExpression += '  "${field.name}": ${field.writeExpression()},';
        }
        toJsonExpression += '}';
        //print(toJsonExpression);
        toJsonMethod
          ..name = 'toJson'
          ..returns = refer('JsonObject?')
          ..body = Code("return $toJsonExpression;");
      }),
      Method((cloner) => cloner
        ..overridden()
        ..name = 'clone'
        ..returns = refer(name)
        ..body = Code("return ${name}.fromMap(this.toMap());")),
      Method((operatorSet) => operatorSet
        ..overridden()
        ..name = 'operator []='
        ..returns = refer('void')
        ..requiredParameters.addAll([
          Parameter((p) => p
            ..name = 'key'
            ..type = refer('String')),
          Parameter((p) => p..name = 'value'),
        ])
        ..body = CodeBuilder.build((builder) {
          builder.block("switch(key)", (cases) {
            for (var fld in sourceFields) {
              builder += 'case "${fld.name}":';
              builder += '  this.${fld.name} = value as ${fld.nullableDartTypeName};';
              builder += '  break;';
            }
            builder += 'default: throw "No field \${key} found for $name";';
          });
        })),
      Method((operatorGet) => operatorGet
        ..name = 'operator []'
        ..overridden()
        ..returns = refer('dynamic')
        ..requiredParameters.addAll([
          Parameter((p) => p..name = 'key'),
        ])
        ..body = Code("""
                  switch(key) {
                    ${sourceFields.map((fld) => 'case "${fld.name}": return this.${fld.name};\n').join('\n')}
                    default: 
                      throw "No field \${key} found on ${name}";
                  }
                  """)),
    ])
    ..fields.addAll([
      for (var field in sourceFields)
        Field((f) => f
          ..name = field.mappedName
          ..type = refer(field.nullSafeType)),
    ]);
}
