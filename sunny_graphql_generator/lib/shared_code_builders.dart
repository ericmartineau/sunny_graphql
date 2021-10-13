import 'package:code_builder/code_builder.dart';
import 'package:gql/ast.dart';
import 'package:sunny_graphql_generator/shared.dart';

import 'class_builder/class_code_builder.dart';
import 'code_builder.dart';
import 'shared.dart';
import 'model.dart';

typedef ClassSnippetGenerator = void Function(
    ClassBuilder builder, String name, Iterable<FieldDefinition> fields, bool isAbstract);

extension GraphScanSharedBuilder on GraphQLScanResult {
  void addAllModels(
    CodeBuilder code, {
    ClassSnippetGenerator? extraGenerator,
    ClassSnippetGenerator? inputGenerator,
  }) {
    final fragmentNames = <String>[];
    log.info('Writing Objects');
    declaredObjectTypes.forEach((def) {
      code += classDefinition(
        this,
        def.name,
        fromJson: true,
        toJson: true,
        toMap: true,
        isInput: false,
        directives: def.directives,
        isJoinRecord: def.directives.any((element) => element.name.value == 'joinRecord'),
        interfaces: def.interfaces,
        fields: def.fields.map(
          (d) => FieldDefinition.ofField(this, d),
        ),
        extraGenerator: extraGenerator,
      );

      /// Add paths and fields?
      code += [
        'class ${def.name.value}Fields {',
        '  const ${def.name.value}Fields._();',
        for (var field in def.fields.map((f) => FieldDefinition.ofField(this, f)))
          '  static const ${field.name} = "${field.name}";',
        '  static const values = {',
        for (var field in def.fields) '      ${field.name.value},',
        '  };',
        '}',
      ];

      /// Add paths and fields?
      code += [
        'class ${def.name.value}Paths {',
        '  const ${def.name.value}Paths._();',
        for (var field in def.fields.map((f) => FieldDefinition.ofField(this, f)))
          '  static const ${field.name} = JsonPath<${field.nullableDartTypeName}>.single("${field.name}");',
        '  static const values = [',
        for (var field in def.fields) '      ${field.name.value},',
        '  ];',
        '}',
      ];
    });
    log.info('Writing Interfaces');
    this.declaredInterfaceTypes.forEach((def) {
      code += classDefinition(
        this,
        def.name,
        toJson: false,
        toMap: false,
        fromJson: false,
        isInput: false,
        isJoinRecord: false,
        directives: def.directives,
        fields: def.fields.map((d) => FieldDefinition.ofField(this, d)),
        isAbstract: true,
      );
    });

    log.info('Writing Inputs');
    this.declaredInputTypes.forEach((def) {
      code += classDefinition(
        this,
        def.name,
        fromJson: true,
        toJson: true,
        toMap: true,
        isInput: true,
        directives: def.directives,
        isJoinRecord: false,
        fields: def.fields.map((d) => FieldDefinition.ofInput(this, d)),
        extraGenerator: inputGenerator,
      );
    });

    log.info('Writing Enum');
    this.declaredEnumTypes.forEach((def) {
      code += [
        'class ${def.name.value} extends GraphEnum<String> {',
        for (var field in def.values) '  static const ${field.name.value} = ${def.name.value}("${field.name.value}");',
        '  static const values = [${def.values.map((v) => v.name.value).join(',')}];',
        '  const ${def.name.value}(String value): super(value);',
        '  factory ${def.name.value}.fromJson(json) {',
        '    switch(json!.toString().toLowerCase()) {',
        for (var field in def.values)
          '      case "${field.name.value.toLowerCase()}": return ${def.name.value}.${field.name.value};',
        '      default: throw "Enum not recognized \${json}";',
        '    }',
        '  }',
        '}',
      ];
    });
    log.info('Writing Fragments');
    this.fragments.values.forEach((def) {
      fragmentNames.add(def.name.value);
      code += [
        'final ${def.name.value} = gql(""" fragment ${def.name.value} on ${def.name.value.replaceAll("Fragment", "")} {',
        def.selectionSet.serialize(1),
        '}""");',
        '',
      ];
    });
  }
}

extension FieldDefinitionCodeExt on FieldDefinition {
  Expression readExpression([String from = 'json']) {
    final fieldDef = this.original is FieldDefinitionNode ? this.original as FieldDefinitionNode : null;
    final isJoinRecord = fieldDef?.directives
            .where((element) => element.name.value == 'relationship')
            .any((element) => element.arguments.any((element) => element.name.value == 'properties')) ==
        true;

    var selectName = this.name;
    if (isJoinRecord) {
      selectName += 'Connection';
    }

    late Expression jsonExpr;
    if (isJoinRecord) {
      jsonExpr = refer("GraphClientConfig.getDeep").call([
        refer(from),
        literalString(selectName),
        literalString(isList ? "edges" : "edge"),
      ]);
    } else {
      jsonExpr = refer(from).index(literalString(selectName));
    }
    switch (this.typeNode.toRawType().toLowerCase()) {
      case 'float':
        return refer('GraphClientConfig.doubleOf').call([jsonExpr]);
      case 'double':
        return refer('GraphClientConfig.doubleOf').call([jsonExpr]);
      case 'int':
        return refer('GraphClientConfig.intOf').call([jsonExpr]);
      case 'string':
      case 'boolean':
      case 'id':
        return jsonExpr.asA(refer(this.typeNode.toDartType()));
      default:
        return refer('GraphClientConfig.read${isList ? 'List' : ''}').call([
          jsonExpr
        ], {
          'typeName': literalString(typeNode.toDartType(withNullability: false)),
          'isNullable': literalBool(!isNonNull),
        });
    }
  }

  String writeExpression([String? source]) {
    source ??= 'this.${name}';

    switch (this.typeNode.toRawType().toLowerCase()) {
      case 'float':
        return 'GraphClientConfig.doubleOf($source)';
      case 'double':
        return 'GraphClientConfig.doubleOf($source)';
      case 'int':
        return 'GraphClientConfig.intOf($source)';
      case 'string':
      case 'boolean':
      case 'id':
        return source;
      default:
        return 'GraphClientConfig.write($source, typeName: "${typeNode.toDartType(withNullability: false)}", isList: ${isList})';
    }
  }

  // Expression writeExpression() {
  //   final serializer = refer('this').property(this.name);
  //
  //   switch (this.typeNode.toRawType().toLowerCase()) {
  //     case 'float':
  //     case 'string':
  //     case 'double':
  //     case 'boolean':
  //     case 'int':
  //     case 'id':
  //       return serializer;
  //     default:
  //       return refer('GraphClientConfig.write').call([
  //         serializer
  //       ], {
  //         'typeName': literalString(typeNode.toDartType(withNullability: false)),
  //         'isList': literalBool(isList),
  //       });
  //   }
  // }
}

extension MethodBuilderExt on MethodBuilder {
  void overridden() {
    this.annotate('override');
  }

  void annotate(String annotation) {
    this.annotations.add(refer(annotation));
  }
}
