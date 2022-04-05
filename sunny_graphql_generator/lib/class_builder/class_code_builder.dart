import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart';
import 'package:sunny_graphql_generator/class_builder/build_abstract_class.dart';
import 'package:sunny_graphql_generator/class_builder/build_base_class.dart';
import 'package:sunny_graphql_generator/code_builder.dart';
import 'package:sunny_graphql_generator/model.dart';

import '../shared.dart';
import '../shared_code_builders.dart';
import 'build_input_class.dart';
import 'build_result_class.dart';

final nameRegex = RegExp("(Create|Update)Input");
Class classDefinition(
  GraphQLScanResult model,
  NameNode nameNode, {
  required bool toJson,
  required bool toMap,
  required bool fromJson,
  required bool isInput,
  bool isData = false,
  Iterable<String> subTypes = const {},
  required bool isJoinRecord,
  Iterable<String> interfaces = const [],
  required Iterable<FieldDefinition> fields,
  required List<DirectiveNode> directives,
  bool isAbstract = false,
  ClassSnippetGenerator? extraGenerator,
}) {
  String name = nameNode.value;
  String? mixin = model.getMixin(name);
  final match = nameRegex.firstMatch(nameNode.value);
  final suffix = (match?.group(1) ?? '') + (isInput ? 'Input' : '');
  var rootName = nameNode.value.replaceAll(nameRegex, '');
  var sourceFields = fields.where((s) => !s.name.endsWith('Connection'));

  if (name.endsWith('Where')) {
    sourceFields = sourceFields.where((element) => element.name == 'id');
  }

  var c = Class(
    (classDef) {
      final isJoinInterface = directives.hasDirective('relationshipProperties');
      if (isJoinInterface) {
        isAbstract = false;
        isJoinRecord = true;
        classDef..implements.add(refer("JoinRecordData"));
      }

      final annotatedMixins = isInput ? directives.mixinInputNames : directives.mixinNames;
      final annotatedInterfaces = isInput ? directives.interfaceInputNames : directives.interfaceNames;
      var ifaces = <String>{
        for (var extra in model.getExtraInterfaces(rootName)) '${extra.toDartType(withNullability: false)}${suffix}',
        ...annotatedInterfaces,
        for (var iface in interfaces)
          if (!iface.contains("Mixin")) iface,
      };

      var mixins = <String>{
        ...annotatedMixins,
        if (mixin.isNotNullOrBlank) mixin!,
        for (var iface in interfaces)
          if (iface.contains("Mixin")) iface,
      };

      classDef
        ..name = name
        ..abstract = isAbstract
        ..mixins.addAll([
          if (!isAbstract)
            for (var mixin in mixins) refer(mixin),
        ])
        ..implements.addAll([
          if (isData && !isAbstract)
            refer('${name}Data')
          else ...[
            for (var interface in ifaces) refer(interface),
          ]
        ]);

      if (subTypes.isNotEmpty) {
        buildBaseClass(
          classDef,
          toJson: toJson,
          toMap: toMap,
          isInput: isInput,
          subTypes: subTypes.toSet(),
          sourceFields: sourceFields,
        );
        return;
      } else if (isAbstract) {
        buildAbstractClass(
          classDef,
          toJson: toJson,
          toMap: toMap,
          sourceFields: sourceFields,
          isData: isData,
        );
        return;
      }

      if (!isJoinRecord) {
        classDef
          ..implements.add(refer('MBaseModel'))
          ..methods.addAll(
            [
              Method(
                (f) => f
                  ..name = 'mtype'
                  ..type = MethodType.getter
                  ..returns = refer('MSchemaRef')
                  ..body = Code('return ${rootName}.ref;'),
              ),
              Method(
                (f) => f
                  ..name = 'mfields'
                  ..type = MethodType.getter
                  ..returns = refer('Set<String>')
                  ..body = Code('return ${rootName}Fields.values;'),
              ),
            ],
          );
      }

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
          isEntity: !isJoinRecord,
        );
      }

      extraGenerator?.call(classDef, nameNode.value, fields, isAbstract);
    },
  );

  return c;
}
