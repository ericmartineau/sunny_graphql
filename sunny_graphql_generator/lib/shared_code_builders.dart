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
      // If there are union types, add them now
      final unionInterfaces = this
          .unionTypes
          .values
          .where((union) => union.types.any((t) {
                return t.name.value == def.name.value;
              }))
          .map((e) => e.name.value)
          .toSet();
      code += classDefinition(
        this,
        '${def.name.value}Data'.toNameNode(),
        isAbstract: true,
        fromJson: true,
        toJson: true,
        toMap: true,
        isInput: false,
        isData: true,
        directives: def.directives,
        isJoinRecord: def.directives.hasDirective('joinRecord'),
        interfaces: [
          ...unionInterfaces,
          ...def.interfaces.map(
            (e) => e.toDartType(withNullability: false),
          )
        ],
        fields: def.fields.map(
          (d) => FieldDefinition.ofField(this, d, entityName: def.name.value),
        ),
        extraGenerator: extraGenerator,
      );

      code += classDefinition(
        this,
        def.name,
        fromJson: true,
        toJson: true,
        toMap: true,
        isInput: false,
        isData: true,
        directives: def.directives,
        isJoinRecord: def.directives.hasDirective('joinRecord'),
        interfaces: [
          '${def.name.value}Data',
          ...def.interfaces.map(
            (e) => e.toDartType(withNullability: false),
          )
        ],
        fields: def.fields.map(
          (d) => FieldDefinition.ofField(this, d, entityName: def.name.value),
        ),
        extraGenerator: extraGenerator,
      );

      /// Add paths and fields?
      code += [
        'class ${def.name.value}Fields {',
        '  const ${def.name.value}Fields._();',
        for (var field in def.fields.map((f) => FieldDefinition.ofField(this, f, entityName: def.name.value)))
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
        for (var field in def.fields.map((f) => FieldDefinition.ofField(this, f, entityName: def.name.value)))
          '  static const ${field.name} = JsonPath<${field.nullableDartTypeName}>.single("${field.name}");',
        '  static const values = [',
        for (var field in def.fields) '      ${field.name.value},',
        '  ];',
        '}',
      ];
    });
    log.info('Writing Unions');
    unionTypes.values.forEach((union) {
      final unionInterface = union.directives.getDirectiveValue('union', 'interface').stringValueOrNull;
      late List<FieldDefinition> fields;
      if (unionInterface != null) {
        final unionInterfaceDef = interfaceTypes[unionInterface]!;
        fields = unionInterfaceDef.fields.map((field) {
          return FieldDefinition.ofField(this, field, entityName: union.name.value);
        }).toList();
      } else {
        fields = [];
      }
      code += classDefinition(
        this,
        union.name,
        fromJson: false,
        toJson: true,
        toMap: true,
        isInput: false,
        subTypes: union.types.map((t) => t.name.value),
        directives: union.directives,
        isJoinRecord: union.directives.hasDirective('joinRecord'),
        interfaces: [],
        fields: fields,
        extraGenerator: extraGenerator,
      );

      //Input
      code += classDefinition(
        this,
        '${union.name.value}CreateInput'.toNameNode(),
        fromJson: false,
        toJson: true,
        toMap: false,
        isInput: true,
        isAbstract: true,
        subTypes: union.types.map((t) => t.name.value),
        directives: union.directives,
        isJoinRecord: union.directives.hasDirective('joinRecord'),
        interfaces: [],
        fields: [],
        extraGenerator: extraGenerator,
      );

      //Input
      code += classDefinition(
        this,
        '${union.name.value}UpdateInput'.toNameNode(),
        fromJson: false,
        toJson: true,
        toMap: false,
        isInput: true,
        isAbstract: true,
        subTypes: union.types.map((t) => t.name.value),
        directives: union.directives,
        isJoinRecord: union.directives.hasDirective('joinRecord'),
        interfaces: [],
        fields: [],
        extraGenerator: extraGenerator,
      );
    });

    log.info('Writing Interfaces');
    this.declaredInterfaceTypes.forEach((def) {
      if (!def.directives.hasDirective('unionInterface')) {
        code += classDefinition(
          this,
          def.name,
          toJson: false,
          toMap: false,
          fromJson: false,
          isInput: false,
          isJoinRecord: false,
          directives: def.directives,
          fields: def.fields.map((d) => FieldDefinition.ofField(this, d, entityName: def.name.value)),
          isAbstract: true,
        );
      }
    });

    log.info('Writing typedefs');
    this.typedefs.forEach((name, definition) {
      code += 'typedef $name = $definition;';
    });

    log.info('Writing Input Ref Aliases');
    final handled = <String>{};
    this.declaredInputTypes.expand((element) => element.fields).forEach((field) {
      var refAlias = field.directives.getDirectiveValue('ref', 'alias').stringValueOrNull;
      final fieldType = field.type.toDartType(withNullability: false);
      if (refAlias != null && !handled.contains(fieldType)) {
        handled.add(fieldType);
        code += "typedef $fieldType = ${refAlias};";
      }

      var refListAlias = field.directives.getDirectiveValue('reflist', 'alias').stringValueOrNull;
      var targetType = field.directives.getDirectiveValue('reflist', 'target').stringValueOrNull;
      if (refListAlias != null && targetType != null && !handled.contains(targetType)) {
        handled.add(targetType);
        code += "typedef $targetType = ${refListAlias};";
      }
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
        fields: def.fields.map((d) => FieldDefinition.ofInput(this, d, entityName: def.name.value)),
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
        'final ${def.name.value} = gql("""',
        'fragment ${def.name.value} on ${def.typeCondition.on.toGQLType(withNullability: false)} {',
        def.selectionSet.serialize(1),
        '}',
        '""").definitions.whereType<FragmentDefinitionNode>().first;',
        '',
      ];
    });
  }
}

extension FieldDefinitionCodeExt on FieldDefinition {
  Expression readExpression([String from = 'json']) {
    final fieldDef = this.original is FieldDefinitionNode ? this.original as FieldDefinitionNode : null;
    final isJoinRecord = fieldDef?.directives.getDirectiveValue("relationship", "properties").stringValueOrNull != null;

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
        return jsonExpr.asA(refer(this.nullableDartTypeName));
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
