import 'package:code_builder/code_builder.dart';
import 'package:gql/ast.dart';
import 'package:sunny_graphql_generator/code_builder.dart';

import '../shared.dart';
import '../shared_code_builders.dart';

void buildInputClass(
  ClassBuilder classDef, {
  required Iterable<FieldDefinition> allFields,
  required Iterable<FieldDefinition> sourceFields,
  required Iterable<DirectiveNode> directives,
}) {
  classDef
    ..constructors.addAll([
      Constructor(
        (ctr) => ctr
          ..optionalParameters.addAll([
            for (var field in sourceFields)
              field.toParameter(
                isThis: false,
                forceOptional: true,
              ),
          ])
          ..initializers.add(
            CodeBuilder.build(
              (builder) {
                builder += "_data = {";
                for (var field in sourceFields) {
                  builder += ' if (${field.name} != null) "${field.name}": ${field.name},';
                }
                builder += "}";
              },
            ),
          ),
      ),
      Constructor(
        (ctr) => ctr
          ..name = 'fromJson'
          ..requiredParameters.add(
            Parameter((p) => p
              ..name = "json"
              ..toThis = false
              ..named = false),
          )
          ..initializers.add(
            Code('_data = json as Map<String, dynamic>'),
          ),
      )
    ])
    ..fields.add(SimpleField("_data", "Map<String, dynamic>", modifier: FieldModifier.final$))
    ..methods.addAll([
      for (var field in sourceFields) ...[
        Method(
          (m) => m
            ..type = MethodType.getter
            ..name = field.mappedName
            ..returns = refer(field.nullSafeType)
            ..body = Code('return this.get("${field.mappedName}");'),
        ),
        Method.returnsVoid(
          (m) => m
            ..type = MethodType.setter
            ..requiredParameters.add(
              Parameter((p) => p
                ..name = field.mappedName
                ..type = refer(field.nullSafeType)),
            )
            ..name = field.mappedName
            ..body = Code('_data["${field.mappedName}"] = ${field.mappedName};'),
        ),
      ],
      Method((set) => set
        ..overridden()
        ..name = 'operator []='
        ..returns = refer('void')
        ..requiredParameters.addAll([
          Parameter((p) => p
            ..name = 'key'
            ..type = refer('String')),
          Parameter((p) => p..name = 'value'),
        ])
        ..body = CodeBuilder.build((body) {
          body += 'if (this._data[key] != value) {';
          body += '  this._data[key] = value;';
          body += '}';
        })),
      Method((get) => get
        ..overridden()
        ..name = 'operator []'
        ..returns = refer('dynamic')
        ..requiredParameters.addAll([
          Parameter((p) => p..name = 'key'),
        ])
        ..body = Code('return this._data[key];')),
      Method((m) => m
        ..name = 'toMap'
        ..returns = refer('JsonObject')
        ..body = Code('return this._data;')),
      Method(
        (privateJsonMethod) => privateJsonMethod
          ..name = '_fieldJson'
          ..requiredParameters.addAll([
            Parameter((key) => key
              ..name = 'json'
              ..type = refer('Map<String, dynamic>')),
            Parameter((key) => key
              ..name = 'key'
              ..type = refer('String')),
            Parameter((value) => value..name = 'value'),
          ])
          ..body = CodeBuilder.lines(
            [
              "  switch (key) {",
              for (var field in sourceFields)
                if (!field.isRelationship) ...[
                  '    case "${field.name}": ',
                  '      final _output = ${field.writeExpression('value')};',
                  '      if (_output != null && _output != "") {',
                  '        json["${field.name}"] = _output;',
                  '      }',
                  '      break;',
                ],
              "  }",
            ],
          ),
      ),
      Method((relatedJsonMethod) {
        var relatedJsonExpr = '';
        if (allFields.related.isNotEmpty) {
          relatedJsonExpr += '...?relatedToJson([';
          for (var field in sourceFields) {
            if (field.isRelationship) {
              relatedJsonExpr += 'relatedFieldJson("${field.name}", this.${field.name}?.relatedJson),\n';
            }
          }

          relatedJsonExpr += ']),\n';
        }

        relatedJsonExpr = '{ $relatedJsonExpr }';
        relatedJsonMethod
          ..name = '_relatedJson'
          ..returns = refer('dynamic')
          ..body = Code("return $relatedJsonExpr;");
      }),
      Method((toJsonMethod) {
        //print(toJsonExpression);
        toJsonMethod
          ..name = 'toJson'
          ..returns = refer('JsonObject?')
          ..body = CodeBuilder.build((builder) {
            builder += [
              "var _json = <String, dynamic>{ ...?_relatedJson(), };",
              "for(var entry in this._data.entries) {",
              "  _fieldJson(_json, entry.key, entry.value);",
              "}",
              "",
              "return _json;",
            ];
          });
      })
    ]);
}
