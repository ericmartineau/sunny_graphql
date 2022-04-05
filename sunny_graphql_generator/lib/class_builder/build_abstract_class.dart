import 'package:code_builder/code_builder.dart';

import '../shared.dart';

void buildAbstractClass(
  ClassBuilder classDef, {
  required bool toJson,
  required bool toMap,
  required bool isData,
  required Iterable<FieldDefinition> sourceFields,
}) {
  classDef
    ..methods.addAll([
      if (toJson && !isData) Method((m) => m..name = 'relatedJson'),
      if (toMap && !isData)
        Method((m) => m
          ..name = 'toMap'
          ..returns = refer('Map<String, dynamic>')),
      for (var field in sourceFields) ...[
        Method((m) => m
          ..type = MethodType.getter
          ..name = field.mappedName
          ..returns = refer(field.nullSafeType)),
        Method((m) => m
          ..type = MethodType.setter
          ..requiredParameters.add(
            Parameter((p) => p
              ..name = field.mappedName
              ..type = refer(field.nullSafeType)),
          )
          ..name = field.mappedName),
      ],
    ]);
}
