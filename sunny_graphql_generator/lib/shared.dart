import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart';
import 'package:sunny_dart/helpers.dart';
import 'package:sunny_graphql_generator/graphql_entity.dart';
import 'package:sunny_graphql_generator/model.dart';
import 'package:sunny_graphql_generator/neo4j/graphql_neo4j_scanner.dart';

String? fieldName(Element element) {
  return element.name;
}

class FieldDefinition {
  final GraphQLScanResult model;
  final String name;
  final String dartTypeName;
  final String entityName;

  final List<InputValueDefinitionNode> args;
  final bool isNonNull;
  final bool isList;
  final TypeNode typeNode;
  final Node original;
  final GraphQLRelation? relationship;
  final bool isEager;
  final String? eagerPrefix;
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
    required this.entityName,
    this.isReadOnly = false,
    this.isFlattened = false,
    this.isId = false,
    this.isEager = false,
    this.eagerPrefix,
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
    required this.entityName,
  })  : name = node.name.value,
        original = node,
        isId = node.isId,
        isAutogenerateId = node.isAutogenerateId,
        isReadOnly = node.isReadOnly,
        isEager = node.isEager,
        eagerPrefix = node.eagerPrefix,
        isLazy = node.isLazy,
        relationship = (node.missingDirective('relationship')
            ? null
            : GraphQLRelation(
                belongsTo: entityName,
                fieldName: node.name.value,
                isLazy: node.isLazy,
                isEager: node.isEager,
                eagerPrefix: node.eagerPrefix,
                propsType: node.directives.getDirectiveValue('relationship', 'properties')?.stringValue,
              )),
        isWriteOnly = node.isWriteOnly,
        isFlattened = node.isFlattened,
        isRelationship = node.hasDirective('relationship'),
        isList = node.type is ListTypeNode,
        args = node.args,
        typeNode = (node.directives.getDirectiveValue('relationship', 'properties')?.stringValue != null
            ? NamedTypeNode(name: NameNode(value: buildJoinRecordName(entityName, node.name.value)))
            : (node.type is ListTypeNode ? (node.type as ListTypeNode).type : node.type)),
        dartTypeName = node.type.toDartType(withNullability: false),
        isNonNull = node.type.isNonNull;

  String get mappedName => model.fieldName(name);

  String? get joinRecordType => relationship?.propsType == null ? null : buildJoinRecordName(entityName, name);

  String get nullableDartTypeName {
    return '$dartTypeName${isNonNull ? '' : '?'}';
  }

  bool get isNullable => !isNonNull;

  String get nullableDartOrListTypeName {
    return this.isList ? 'List<${dartTypeName}>' : nullableDartTypeName;
  }

  String get relationType {
    var ext = (relationship?.propsType != null) ? "Ext" : "";
    if (!isList && isNullable) {
      return "Nullable${ext}GraphRef";
    } else if (!isList) {
      return "${ext}GraphRef";
    } else {
      return "${ext}GraphRefList";
    }
  }

  String get singularRelationType {
    var ext = (joinRecordType != null) ? "Ext" : "";
    return "${ext}GraphRef";
  }

  /// The name of the related type of this entity, regardless of whether this is a list of singular
  ///
  /// For example if this field is:
  /// tribes: TribeRefList
  ///
  /// then [singularRefType] will point to [Tribe]
  String get singularRefType {
    final field = this;

    var dartType = field.joinRecordType ?? field.typeNode.toDartType(withNullability: false);
    var inputType = dartType;
    if (this.relationship?.propsType != null) {
      if (field.original is FieldDefinitionNode) {
        inputType = field.joinRecordType ?? (field.original as FieldDefinitionNode).type.toRawType();
      }
    }

    return '${inputType}Ref';
  }

  String relationRefType() {
    final field = this;
    var dartType = relationship?.propsType ?? field.typeNode.toDartType(withNullability: false);
    var inputType = dartType;
    var type = "${field.relationType}<";
    if (this.relationship?.propsType != null) {
      if (field.original is FieldDefinitionNode) {
        type += "${(field.original as FieldDefinitionNode).type.toRawType()}, ";
        inputType = (field.original as FieldDefinitionNode).type.toRawType();
      }
    }
    type += "${dartType}, ${inputType}CreateInput, ${inputType}UpdateInput";
    if (isList) {
      type += ', ${singularRefType}';
    }
    type += '>';
    return type;
  }

  String relationSingularRefType() {
    if (!isList) {
      throw "Must be list type";
    }

    final field = this;
    var dartType = relationship?.propsType ?? field.typeNode.toDartType(withNullability: false);
    var inputType = dartType;
    var type = "${field.singularRelationType}<";
    if (this.relationship?.propsType != null) {
      if (field.original is FieldDefinitionNode) {
        type += "${(field.original as FieldDefinitionNode).type.toRawType()}, ";
        inputType = (field.original as FieldDefinitionNode).type.toRawType();
      }
    }
    type += "${dartType}, ${inputType}CreateInput, ${inputType}UpdateInput>";
    return type;
  }

  String relationRefAlias() {
    final field = this;
    var dartType = field.typeNode.toDartType(withNullability: false);
    var inputType = dartType;
    var relatedName = this.joinRecordType ?? inputType;
    var baseName = '${relatedName}Ref';
    return isList
        ? '${baseName}List'
        : isNullable
            ? 'Nullable$baseName'
            : baseName;
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

  @override
  String toString() {
    return "$name: joinType: ${this.joinRecordType}, dartType: ${dartTypeName}";
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
    return '${definitionType.name.value}.fromJson(${ofExpr}!)';
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
  'datetime': 'DateTime',
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

    return '$str\n';
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

List<Method> getterSetter(String name, String type, {bool isAbstract = true}) {
  return [
    getter(name, type, isAbstract: isAbstract),
    setter(name, type, isAbstract: isAbstract),
  ];
}

Method getter(String name, String type, {bool isAbstract = true}) {
  return Method((m) => m
    ..name = name
    ..type = MethodType.getter
    ..returns = refer(type)
    ..body = isAbstract ? null : Code('return this.$name;'));
}

Method setter(String name, String type, {bool isAbstract = true}) {
  return Method((m) => m
    ..name = name
    ..type = MethodType.setter
    ..requiredParameters.add(Parameter((p) => p
      ..type = refer(type)
      ..name = name))
    ..body = isAbstract ? null : Code('this.$name = $name;'));
}

FieldNode fieldNode(String name, {Iterable selectionSet = const []}) {
  return FieldNode(
      name: name.toNameNode(),
      selectionSet: SelectionSetNode(
        selections: [
          for (var selection in selectionSet)
            if (selection is String)
              if (selection.startsWith("..."))
                FragmentSpreadNode(name: selection.substring(3).toNameNode())
              else
                FieldNode(name: selection.toNameNode())
            else if (selection is SelectionNode)
              selection
            else
              illegalState("Invalid selectionSet type: ${selection.runtimeType}"),
        ],
      ));
}

DirectiveNode directiveNode(String name, {Map<String, Object?> args = const {}}) {
  return DirectiveNode(name: NameNode(value: name), arguments: [
    for (var entry in args.entries) ArgumentNode(name: NameNode(value: entry.key), value: entry.value.toValueNode()),
  ]);
}

extension SGQLDirectivesNode on DirectiveNode {
  ValueNode? getArgument(String key) =>
      this.arguments.where((element) => element.name.value == key).map((arg) => arg.value).firstOr();
}

extension ListDirectivesNode on Iterable<DirectiveNode> {
  Set<String> get interfaceNames => getList<String>('interfaces', 'name', 'names').toSet();
  Set<String> get interfaceApiNames => getList<String>('interfaces', 'api', 'apis').toSet();
  Set<String> get interfaceInputNames => getList<String>('interfaces', 'input', 'inputs').toSet();
  Set<String> get mixinNames => getList<String>('mixin', 'name', 'names').toSet();
  Set<String> get mixinApiNames => getList<String>('mixin', 'api', 'apis').toSet();
  Set<String> get mixinInputNames => getList<String>('mixin', 'input', 'inputs').toSet();

  String? getString(String directive, String argument) => getDirectiveValue(directive, argument).get();
  List<T> getList<T extends Object>(String directive, String argument, [String? argument2, String? argument3]) => <T?>[
        for (var argName in [argument, argument2, argument3].whereType<String>())
          for (var value in getDirectiveValues(directive, argName)) ...[
            value.tryGet<T>(),
            ...value.tryGetList<T>(),
          ],
      ].whereType<T>().cast<T>().toList();

  DirectiveNode? getDirective(String name) => where((element) => element.name.value == name).firstOr();
  Iterable<DirectiveNode> getDirectives(String name) => where((element) => element.name.value == name);

  ValueNode? getDirectiveValue(String directive, String argument) =>
      getDirective(directive)?.arguments.where((e) => e.name.value == argument).firstOr()?.value;

  Iterable<ValueNode> getDirectiveValues(String directive, String argument) => getDirectives(directive)
      .expand((directive) => directive.arguments.where((e) => e.name.value == argument))
      .map((d) => d.value);

  bool hasDirective(String name) => any((element) => element.name.value == name);
}

extension FieldDefinitionNodeExt on FieldDefinitionNode {
  DirectiveNode? getDirective(String name) => directives.where((element) => element.name.value == name).firstOr();

  ValueNode? getDirectiveValue(String directive, String argument) =>
      getDirective(directive)?.arguments.where((e) => e.name.value == argument).firstOr()?.value;

  bool hasDirective(String name) => directives.any((element) => element.name.value == name);

  bool missingDirective(String name) => !hasDirective(name);

  bool get isReadOnly => hasDirective('readonly');

  bool get isWriteOnly => hasDirective('writeOnly');

  bool get isFlattened => hasDirective('flatten');

  bool get isEager => hasDirective('eager');

  String? get eagerPrefix => getDirectiveValue("eager", "prefix").stringValueOrNull;

  bool get isId => hasDirective('id');

  bool get isAutogenerateId => hasDirective('id') && getDirectiveValue('id', 'autogenerate').boolValue(true);

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

extension ValueNodeExt on ValueNode? {
  bool boolValue([bool defaultValue = false]) => get<bool?>() ?? defaultValue;
  String get stringValue => get();
  String? get stringValueOrNull => get();

  T get<T extends Object?>() {
    return _anyValue as T;
  }

  List<T> getList<T extends Object?>() {
    return (_anyValue as List).whereType<T>().toList().cast<T>();
  }

  T? tryGet<T extends Object>() {
    final val = _anyValue;
    return val is T ? val : null;
  }

  List<T> tryGetList<T extends Object>() {
    return tryGet<List>()?.whereType<T>().toList().cast<T>() ?? const [];
  }

  Object? get _anyValue {
    final self = this;
    if (self == null) return null;
    if (self is BooleanValueNode) {
      return self.value;
    } else if (self is StringValueNode) {
      return self.value;
    } else if (self is IntValueNode) {
      return self.value;
    } else if (self is FloatValueNode) {
      return self.value;
    } else if (self is NullValueNode) {
      return null;
    } else if (self is EnumValueNode) {
      return self.name.value;
    } else if (self is ListValueNode) {
      return self.values.mapIndexed((item, index) => item._anyValue);
    } else if (self is ObjectValueNode) {
      return self.fields.map((f) => MapEntry<String, Object?>(f.name.value, f.value._anyValue)).toMap();
    } else {
      throw ArgumentError('Unable to extract from ${self.runtimeType} ValueNode');
    }
  }
}

extension TypeNodeExt on TypeNode {
  String toDartType({bool withNullability = true, bool forceOptional = false}) {
    var isOptional = forceOptional || (withNullability && !this.isNonNull);
    var nullSuffix = isOptional ? '?' : '';
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

extension FieldNodeToParam on FieldDefinition {
  Parameter toParameter({
    bool isThis = false,
    bool named = true,
    bool forceOptional = false,
  }) {
    var dartOrListType = this.dartTypeName;
    if (forceOptional && !dartOrListType.endsWith("?")) {
      dartOrListType += "?";
    }
    return Parameter((p) => p
      ..type = isThis ? null : refer(dartOrListType)
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

extension ObjectToValueNode on Object? {
  ValueNode toValueNode() {
    final self = this;
    if (self == null) return const NullValueNode();
    if (self is String) {
      return StringValueNode(value: self, isBlock: false);
    } else if (self is int) {
      return IntValueNode(value: self.toString());
    } else if (self is num) {
      return FloatValueNode(value: self.toString());
    } else if (self is Iterable<Object?>) {
      return ListValueNode(values: self.map((e) => e.toValueNode()).toList());
    } else if (self is Map<Object?, Object?>) {
      return ObjectValueNode(
          fields: self.entries
              .map((entry) => ObjectFieldNode(
                    name: entry.key.toString().toNameNode(),
                    value: entry.value.toValueNode(),
                  ))
              .toList());
    } else {
      throw "Don't know how to create value node from ${this.runtimeType}";
    }
  }
}

extension StringToNode on String {
  NamedTypeNode toNamedType({bool? isNonNull}) => NamedTypeNode(
        name: this.toNameNode(),
        isNonNull: isNonNull ?? this.endsWith('!'),
      );
  NameNode toNameNode() => NameNode(value: this);
}
