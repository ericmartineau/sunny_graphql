import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart';
import 'package:sunny_graphql_generator/graphql_entity.dart';
import 'package:sunny_graphql_generator/model.dart';

import 'code_builder.dart';
import 'shared_code_builders.dart';

String? fieldName(Element element) {
  return element.name;
}

class FieldDefinition {
  final GraphQLScanResult model;
  final String name;
  final String dartTypeName;

  final List<InputValueDefinitionNode> args;
  final bool isNonNull;
  final bool isList;
  final TypeNode typeNode;
  final Node original;
  final GraphQLRelation? relationship;
  final bool isEager;
  final bool isLazy;
  final bool isReadOnly;
  final bool isWriteOnly;
  final bool isRelationship;
  final bool isFlattened;
  final bool isId;
  final bool isAutogenerateId;

  FieldDefinition.ofInput(
    this.model,
    InputValueDefinitionNode node, {
    this.isReadOnly = false,
    this.isFlattened = false,
    this.isId = false,
    this.isEager = false,
    this.isLazy = false,
    this.isAutogenerateId = false,
    this.isWriteOnly = false,
  })  : name = node.name.value,
        original = node,
        args = [],
        isRelationship = node.type.toRawType().contains('GraphRef'),
        relationship = null,
        typeNode = node.type is ListTypeNode ? (node.type as ListTypeNode).type : node.type,
        isList = node.type is ListTypeNode,
        dartTypeName = node.type.toDartType(withNullability: false),
        isNonNull = node.type.isNonNull;

  FieldDefinition.ofField(
    this.model,
    FieldDefinitionNode node, {
    this.relationship,
  })  : name = node.name.value,
        original = node,
        isId = node.isId,
        isAutogenerateId = node.isAutogenerateId,
        isReadOnly = node.isReadOnly,
        isEager = node.isEager,
        isLazy = node.isLazy,
        isWriteOnly = node.isWriteOnly,
        isFlattened = node.isFlattened,
        isRelationship = relationship != null,
        isList = node.type is ListTypeNode,
        args = node.args,
        typeNode = (relationship?.joinTypeName != null
            ? NamedTypeNode(name: NameNode(value: relationship!.joinTypeName!))
            : (node.type is ListTypeNode ? (node.type as ListTypeNode).type : node.type)),
        dartTypeName = node.type.toDartType(withNullability: false),
        isNonNull = node.type.isNonNull;

  String get mappedName => model.fieldName(name);

  String get nullableDartTypeName {
    return '$dartTypeName${isNonNull ? '' : '?'}';
  }

  String get relationType {
    var ext = (relationship?.propsType != null) ? "Ext" : "";
    if (!isList && !isNonNull) {
      return "Nullable${ext}GraphRef";
    } else if (!isList) {
      return "${ext}GraphRef";
    } else {
      return "${ext}GraphRefList";
    }
  }

  String relationRefType() {
    final field = this;
    var dartType = field.typeNode.toDartType(withNullability: false);
    var inputType = dartType;
    var type = "${field.relationType}<";
    if (this.relationship?.propsType != null) {
      if (field.original is FieldDefinitionNode) {
        type += "${(field.original as FieldDefinitionNode).type.toRawType()}, ";
        inputType = (field.original as FieldDefinitionNode).type.toRawType();
      }
    }
    type += "${dartType}, ${inputType}CreateInput, ${inputType}UpdateInput>";
    return type;
  }

  String get nullSafeType {
    var isNonNull = this.isNonNull && this.args.isEmpty;
    return "${dartTypeName}${isNonNull ? '' : '?'}";
  }

  bool get canUpdate {
    if (isRelationship) {
      return true;
    }
    return !isReadOnly && !isRelationship && !isId;
  }

  bool get canCreate {
    if (isRelationship) {
      return true;
    }
    return ((isId && !isAutogenerateId) || !isReadOnly) && !isRelationship && !isAutogenerateId;
  }
}

String serializer(DocumentNode doc, String sourceExpr, TypeNode typeNode) {
  assert(typeNode is! ListTypeNode);
  var sourceType = doc.findType(typeNode);
  if (sourceType is EnumTypeDefinitionNode) {
    return sourceExpr;
  } else if (sourceType != null) {
    return "${sourceExpr}?.toJson()";
  } else {
    return sourceExpr;
  }
}

String deserializer(DocumentNode doc, String ofExpr, TypeNode sourceType) {
  assert(sourceType is! ListTypeNode);
  var definitionType = doc.findType(sourceType);
  if (definitionType is EnumTypeDefinitionNode) {
    return 'parse${definitionType.name.value}(${ofExpr})';
  } else if (definitionType != null) {
    return '${definitionType.name.value}.fromJson(${ofExpr}!)';
  } else {
    return ofExpr;
  }
}

extension DocExt on DocumentNode {
  TypeDefinitionNode? findType(TypeNode type) {
    if (type is ListTypeNode) {
      return findType(type.type);
    } else if (type is NamedTypeNode) {
      return findTypeByName(type.name.value);
    } else {
      return type as TypeDefinitionNode?;
    }
  }

  DocumentNode operator +(DocumentNode node) {
    return DocumentNode(definitions: [
      ...this.definitions,
      ...node.definitions,
    ]);
  }

  TypeDefinitionNode? findTypeByName(String typeName) {
    return this.definitions.whereType<TypeDefinitionNode?>().firstWhere(
      (element) => element?.name.value == typeName,
      orElse: () {
        return null;
      },
    );
  }

  T? findByName<T extends TypeDefinitionNode>(String typeName) {
    return this.definitions.whereType<T?>().firstWhere(
      (element) => element?.name.value == typeName,
      orElse: () {
        return null;
      },
    );
  }

  FragmentDefinitionNode? findFragment(String type) {
    return this.definitions.whereType<FragmentDefinitionNode?>().firstWhere(
      (element) => element?.name.value == type,
      orElse: () {
        return null;
      },
    );
  }
}

const mapping = {
  "id": "String",
  "int": "int",
  "double": "double",
  "float": "double",
  "boolean": "bool",
  'uri': 'Uri',
  'iref': 'IRef',
  'timestamp': 'DateTime',
};

extension ArgListNode on List<InputValueDefinitionNode> {
  String toDartType() {
    String str = '';
    this.forEach((element) {
      str += '${element.type.toDartType()} ${element.name.value},';
    });
    return str;
  }
}

extension SelectionSetSerializer on SelectionSetNode {
  String serialize([int indent = 0]) {
    var str = '';
    for (var node in this.selections) {
      str += '${indent.indent()}${node.serialize(indent)}';
    }

    return str;
  }
}

extension IndentNum on num {
  String indent() {
    var str = '';
    for (int i = 0; i < this; i++) str += '  ';
    return str;
  }
}

extension SelectionSetSerializing on SelectionNode {
  String serialize([int indent = 0]) {
    final self = this;
    if (self is FieldNode) {
      var str = '${self.name.value}';
      if (self.selectionSet?.selections.isNotEmpty == true) {
        str += ' {\n';
        self.selectionSet!.selections.forEach((element) {
          str += element.serialize(indent + 1);
        });
        str += '${indent.indent()}}';
      }
      return "${str}\n";
    } else if (self is FragmentSpreadNode) {
      return '${indent.indent()}...${self.name.value}\n';
    } else if (self is InlineFragmentNode) {
      return '${indent.indent()}...on ${self.typeCondition!.on.name.value} { ${self.selectionSet.serialize(indent + 1)} }';
    } else {
      throw "Unsupported selection";
    }
  }
}

extension RawTypeNodeExt on Node {
  String toRawType() {
    if (this is NamedTypeNode) {
      var nt = this as NamedTypeNode;
      return nt.name.value;
    } else if (this is ListTypeNode) {
      final lt = this as ListTypeNode;
      return lt.type.toGQLType();
    } else {
      return 'Object';
    }
  }
}

extension FieldDefinitionNodeExt on FieldDefinitionNode {
  DirectiveNode? getDirective(String name) => directives.where((element) => element.name.value == name).firstOr();

  ValueNode? getDirectiveValue(String directive, String argument) =>
      getDirective(directive)?.arguments.where((e) => e.name.value == argument).firstOr()?.value;

  bool hasDirective(String name) => directives.any((element) => element.name.value == name);

  bool get isReadOnly => hasDirective('readonly');

  bool get isWriteOnly => hasDirective('writeOnly');

  bool get isFlattened => hasDirective('flatten');

  bool get isEager => hasDirective('eager');

  bool get isId => hasDirective('id');

  bool get isAutogenerateId => hasDirective('id') && getDirectiveValue('id', 'autogenerate')?.boolValue != false;

  bool get isLazy => hasDirective('lazy');
}

extension TypeNodeListExt on Iterable<TypeNode> {
  Iterable<String> fragmentDependencies(DocumentNode node, Map<String, Set<String>> depends) {
    return this.expand((t) {
      var rawType = t.toRawType();
      return [...?depends[rawType]];
    });
  }
}

extension ValueNodeExt on ValueNode {
  String? get stringValue {
    if (this is StringValueNode) {
      return (this as StringValueNode).value;
    } else if (this is NullValueNode) {
      return null;
    } else {
      throw "Not a string value type.  Was${this.runtimeType}";
    }
  }

  bool? get boolValue {
    if (this is BooleanValueNode) {
      return (this as BooleanValueNode).value;
    } else {
      return null;
    }
  }
}

extension TypeNodeExt on TypeNode {
  String toDartType({bool withNullability = true, bool forceOptional = false}) {
    var nullSuffix = forceOptional ? '?' : "${!withNullability || this.isNonNull ? '' : '?'}";
    if (this is NamedTypeNode) {
      var nt = this as NamedTypeNode;
      var typeName = mapping[nt.name.value.toLowerCase()] ?? nt.name.value;
      return "${typeName}${nullSuffix}";
    } else if (this is ListTypeNode) {
      final lt = this as ListTypeNode;
      return "List<${lt.type.toDartType()}>${nullSuffix}";
    } else {
      print('${this.runtimeType}');
      return 'dynamic';
    }
  }

  bool nonNull() {
    return this.isNonNull;
  }

  String toSelectionNode(DocumentNode doc) {
    if (this.isObject(doc)) {
      return 'FragmentSpreadNode(name: NameNode(value: "${this.toRawType()}Fragment"))';
    } else {
      return '';
    }
  }

  String fragmentDefinition(DocumentNode doc, Map<String, Set<String>> depends) {
    if (this.isObject(doc)) {
      var fragmentName = '${this.toRawType()}Fragment';
      return "...[${fragmentName}, ${(depends[fragmentName] ?? {}).join(', ')}],";
    } else {
      return '';
    }
  }

  bool isObject(DocumentNode doc) {
    final type = doc.findType(this);
    if (type == null) return false;
    return type is ObjectTypeDefinitionNode || type is InputObjectTypeDefinitionNode;
  }

  String toGQLType({bool withNullability = true}) {
    if (this is NamedTypeNode) {
      var nt = this as NamedTypeNode;
      return nt.name.value;
    } else if (this is ListTypeNode) {
      final lt = this as ListTypeNode;
      return "[${lt.type.toGQLType()}]";
    } else {
      return 'Object';
    }
  }

  String toRawType() {
    if (this is NamedTypeNode) {
      var nt = this as NamedTypeNode;
      return nt.name.value;
    } else if (this is ListTypeNode) {
      final lt = this as ListTypeNode;
      return lt.type.toGQLType();
    } else {
      return 'Object';
    }
  }
}

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
  bool isAbstract = false,
  ClassSnippetGenerator? extraGenerator,
}) {
  String name = nameNode.value;
  String? mixin = model.getMixin(name);
  var sourceFields = fields.where((s) => !s.name.endsWith('Connection'));
  final ifaces = [
    ...interfaces,
    ...model.getExtraInterfaces(name),
  ];

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
          for (var iface in ifaces)
            if (!iface.toDartType(withNullability: false).contains("Mixin")) refer(iface.toDartType(withNullability: false))
        ]);
      if (isAbstract) {
        classDef
          ..methods.addAll([
            if (toJson) Method((m) => m..name = 'relatedJson'),
            if (toMap)
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
        return;
      }

      if (isInput) {
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
                    ..name = "_data"
                    ..toThis = true
                    ..named = false),
                ),
            )
          ])
          ..fields.add(SimpleField("_data", "Map<String, dynamic>", modifier: FieldModifier.final$))
          ..methods.addAll([
            for (var field in sourceFields) ...[
              Method((m) => m
                ..type = MethodType.getter
                ..name = field.mappedName
                ..returns = refer(field.nullSafeType)
                ..body = Code('return this.get("${field.mappedName}");')),
            ],
            Method((set) => set
              ..annotations.add(refer('override'))
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
              ..annotations.add(refer('override'))
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
            Method((toJsonMethod) {
              //print(toJsonExpression);
              toJsonMethod
                ..name = 'toJson'
                ..returns = refer('JsonObject?')
                ..body = CodeBuilder.build((builder) {
                  builder += [
                    "_fieldJson(k, v) {",
                    "  switch (k) {",
                    for (var field in sourceFields)
                      if (!field.isRelationship) 'case "${field.name}": return ${field.writeExpression('v')};',
                    "    default: return null;",
                    "  }",
                    "}",
                  ];
                  builder += [
                    "return <String, dynamic>{",
                    "  for(var entry in this._data.entries)",
                    "    entry.key: _fieldJson(entry.key, entry.value),",
                    "};",
                  ];
                });
            })
          ]);
      } else if (!isInput) {
        classDef
          ..constructors.addAll(
            [
              Constructor(
                (ctr) => ctr
                  ..optionalParameters.addAll([
                    for (var field in sourceFields) field.toParameter(isThis: true),
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
                      for (var field in sourceFields)
                        if (!isInput || !field.isRelationship) field.mappedName: field.readExpression(),
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
            Method((toJsonMethod) {
              var toJsonExpression = '{';
              for (var field in sourceFields) {
                if (!isInput || !field.isRelationship) {
                  toJsonExpression += '  "${field.name}": ${field.writeExpression()},';
                }
              }
              toJsonExpression += '}';
              //print(toJsonExpression);
              toJsonMethod
                ..name = 'toJson'
                ..returns = refer('JsonObject?')
                ..body = Code("return $toJsonExpression;");
            }),
            Method((operatorSet) => operatorSet
              ..annotations.add(refer('override'))
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
              ..annotations.add(refer('override'))
              ..name = 'operator []'
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

      classDef.methods.addAll([
        Method((relatedJsonMethod) {
          var relatedJsonExpr = '';
          if (isInput && fields.related.isNotEmpty) {
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
            ..name = 'relatedJson'
            ..returns = refer('FieldRefInput?')
            ..body = Code("return $relatedJsonExpr;");
        }),
      ]);

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

extension FieldNodeToParam on FieldDefinition {
  Parameter toParameter({
    bool isThis = false,
    bool named = true,
    bool forceOptional = false,
  }) {
    return Parameter((p) => p
      ..type = isThis
          ? null
          : refer(typeNode.toDartType(
              forceOptional: forceOptional,
            ))
      ..name = mappedName
      ..toThis = isThis
      ..named = named
      ..required = isNonNull && !forceOptional);
  }
}

extension FieldDefinitionList on Iterable<FieldDefinition> {
  List<FieldDefinition> get lazy => this.where((f) => f.isLazy).toList();
  List<FieldDefinition> get related => this.where((f) => f.isRelationship).toList();
}

extension InputArgToParam on InputValueDefinitionNode {
  Parameter toParameter({bool named = true, bool forceOptional = false}) {
    return Parameter((p) => p
      ..type = refer(type.toDartType())
      ..name = name.value
      ..named = named
      ..required = type.isNonNull && !forceOptional);
  }
}

extension InputArgsToParams on Iterable<InputValueDefinitionNode> {
  Iterable<InputValueDefinitionNode> get required {
    return this.where((element) => element.type.isNonNull);
  }

  Iterable<InputValueDefinitionNode> get optional {
    return this.where((element) => !element.type.isNonNull);
  }
}

extension ReferenceExt on Reference {
  TypeReference typeReference() {
    return type as TypeReference;
  }

  Reference list() {
    return TypeReference((r) => r
      ..symbol = 'List'
      ..types.add(this));
  }

  Reference future() {
    return TypeReference((r) => r
      ..symbol = 'Future'
      ..types.add(this));
  }
}

Field SimpleField(String name, String type, {FieldModifier? modifier}) => Field((field) {
      field
        ..name = name
        ..type = refer(type);
      if (modifier != null) {
        field.modifier = modifier;
      }
    });