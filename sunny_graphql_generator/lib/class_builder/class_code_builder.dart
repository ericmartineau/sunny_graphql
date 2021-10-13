import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart';
import 'package:sunny_graphql_generator/class_builder/build_abstract_class.dart';

import 'package:sunny_graphql_generator/model.dart';

import '../shared.dart';
import '../shared_code_builders.dart';
import 'build_input_class.dart';
import 'build_result_class.dart';

Class classDefinition(
  GraphQLScanResult model,
  NameNode nameNode, {
  required bool toJson,
  required bool toMap,
  required bool fromJson,
  required bool isInput,
  required bool isJoinRecord,
  Iterable<TypeNode> interfaces = const [],
  required Iterable<FieldDefinition> fields,
  required List<DirectiveNode> directives,
  bool isAbstract = false,
  ClassSnippetGenerator? extraGenerator,
}) {
  String name = nameNode.value;
  String? mixin = model.getMixin(name);

  var rootName = nameNode.value.replaceAll(RegExp("(Create|Update)Input"), '');
  var sourceFields = fields.where((s) => !s.name.endsWith('Connection'));

  if (name.endsWith('Where')) {
    sourceFields = sourceFields.where((element) => element.name == 'id');
  }

  var c = Class(
    (classDef) {
      classDef
        ..name = name
        ..abstract = isAbstract
        ..mixins.addAll([
          if (mixin.isNotNullOrBlank) refer(mixin!),
          for (var iface in interfaces)
            if (iface.toDartType(withNullability: false).contains("Mixin")) refer(iface.toDartType(withNullability: false))
        ])
        ..implements.addAll([
          for (var iface in interfaces)
            if (!iface.toDartType(withNullability: false).contains("Mixin")) refer(iface.toDartType(withNullability: false)),
          for (var iface in model.getExtraInterfaces(name)) refer(iface.toDartType(withNullability: false))
        ]);

      if (isAbstract) {
        buildAbstractClass(classDef, toJson: toJson, toMap: toMap, sourceFields: sourceFields);
        return;
      }

      classDef
        ..implements.add(refer('MBaseModel'))
        ..methods.add(
          Method(
            (f) => f
              ..name = 'mtype'
              ..type = MethodType.getter
              ..returns = refer('MSchemaRef')
              ..body = Code('return ${rootName}.ref;'),
          ),
        );

      if (isInput) {
        buildInputClass(
          classDef,
          directives: directives,
          sourceFields: sourceFields,
          allFields: fields,
        );
      } else if (!isInput) {
        buildNonInputClass(
          classDef,
          sourceFields: sourceFields,
          name: name,
          directives: directives,
        );
      }

      extraGenerator?.call(classDef, nameNode.value, fields, isAbstract);
    },
  );
  // [
  //   '${isAbstract ? 'abstract ' : ''}class ${name} ${mixin.isNotNullOrBlank ? ' with ${mixin} ' : ''}${interfaces.isNotEmpty ? "implements ${interfaces.map((e) => e.toDartType(withNullability: false)).join(', ')}" : ''} {',
  //   if (!isAbstract) ...[
  //     '  ${name}({',
  //     for (var field in fields) '    ${field.isNonNull ? 'required ' : ''}this.${field.name},',
  //     '  });',
  //     for (var field in fields) '  ${field.nullSafeType} ${field.name};',
  //     '',
  //     '  dynamic relatedJson() => <String, dynamic>{',
  //     for (var field in fields)
  //       '    "${field.name}":  GraphClientConfig.write(this.${field.name}, typeName: "${field.typeNode.toDartType(withNullability: false)}", isList: ${field.isList}),',
  //     '  };',
  //     '',
  //     '  factory ${name}.fromJson(json) {',
  //     '    return ${name}(',
  //     for (var field in fields)
  //       '    ${field.name}:  GraphClientConfig.read${field.isList ? 'List' : ''}(json["${field.name}"], typeName: "${field.typeNode.toDartType(withNullability: false)}", isNullable: ${!field.isNonNull}),',
  //     '    );',
  //     '  }',
  //   ] else ...[
  //     for (var field in fields) ...[
  //       '  ${field.nullSafeType} get ${field.name};',
  //       '  set ${field.name}(${field.nullSafeType} ${field.name});',
  //     ],
  //     '  dynamic relatedJson();'
  //         ''
  //   ],
  //   '}',
  // ];
  return c;
}
