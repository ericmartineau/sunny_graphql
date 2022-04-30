import 'package:code_builder/code_builder.dart';
import 'package:sunny_graphql_generator/code_builder.dart';

import '../shared.dart';

void buildBaseClass(
  ClassBuilder classDef, {
  required bool toJson,
  required bool toMap,
  required bool isInput,
  required Set<String> subTypes,
  required Iterable<FieldDefinition> sourceFields,
}) {
  classDef
    ..abstract = true
    ..extend = isInput ? null : refer('BaseSunnyEntity')
    ..implements.add(isInput ? refer('GraphInput') : refer('Entity'))
    ..constructors.addAll([
      if (!isInput)
        Constructor((fac) => fac
          ..name = 'fromJson'
          ..factory = true
          ..requiredParameters.add(Parameter((p) => p
            ..name = 'json'
            ..type = refer('dynamic')))
          ..body = CodeBuilder.lines([
            'final type = json["__typename"];',
            'switch (type) {',
            for (var subType in subTypes)
              '  case "${subType}": return ${subType}.fromJson(json);',
            '  default:',
            '    throw "Unknown subtype of ${classDef.name}: \$type";',
            '}',
          ]))
    ]);
}
