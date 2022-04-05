import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:gql/ast.dart';
import 'package:gql/language.dart' as lang;
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_graphql_generator/code_builder.dart';
import 'package:sunny_graphql_generator/graphql_scanner_code_builder.dart';
import 'package:sunny_graphql_generator/model.dart';

import 'shared.dart';
import 'shared.dart' as shared;

final _log = Logger('graphQLScanner');

typedef NameMapper = String Function(String input);

String echo(String input) => input;

class SunnyGraphQLModel implements GraphQLScanResult {
  final objectTypes = <String, ObjectTypeDefinitionNode>{};
  final interfaceTypes = <String, InterfaceTypeDefinitionNode>{};
  final extraInterfaces = <String, Set<TypeNode>>{};
  final inputTypes = <String, InputObjectTypeDefinitionNode>{};
  final enumTypes = <String, EnumTypeDefinitionNode>{};
  final query = <String, FieldDefinitionNode>{};
  final subQuery = <String, FieldDefinitionNode>{};
  final mutation = <String, FieldDefinitionNode>{};
  final unionTypes = <String, UnionTypeDefinitionNode>{};
  final typedefs = <String, String>{};
  final fragments = <String, FragmentDefinitionNode>{};
  final fragmentDepends = FragmentDependencies();
  final subqueries = <String, Map<String, GraphSubQuery>>{};
  final joinRecords = <String>{};
  final NameMapper mapTypeName;
  final NameMapper mapFieldName;
  final Map<String, String> mixinMap;
  final Map<String, String> typeMap;
  final List<RegExp> excludes;
  final List<RegExp> includes;
  final String className;
  final done = <String>{};
  final DocumentNode doc;
  final Map<RegExp, String> typeNameMap;
  final Map<RegExp, String> fieldNameMap;
  Logger get log => _log;

  static Future<SunnyGraphQLModel> initFromAnnotation(Element element, ConstantReader annotation) async {
    assert(element is ClassElement, "@graphQL must only be applied to class");
    final cls = element as ClassElement;
    assert(cls.isAbstract, "@graphQL must be applied to abstract classes");
    var includesValue = annotation.read('includes');
    var excludesValue = annotation.read('excludes');
    var mixinMapValue = annotation.read('mixins');
    var typeMap = annotation.read('typeMap').isMap
        ? annotation.read('typeMap').mapValue.map((key, value) => MapEntry(key!.toStringValue()!, value!.toStringValue()!))
        : <String, String>{};

    var mixinMap = mixinMapValue.isMap
        ? mixinMapValue.mapValue.map((key, value) => MapEntry(key!.toStringValue()!, value!.toStringValue()!))
        : <String, String>{};

    var includesSet = includesValue.isList ? includesValue.listValue.map((d) => d.toStringValue()).toSet() : <String>{};
    var excludeSet = excludesValue.isList ? excludesValue.listValue.map((d) => RegExp(d.toStringValue()!)).toList() : <RegExp>[];
    final concreteName = cls.name.substring(1);

    final sourceUris = [annotation.read('uri'), annotation.read('fragmentUri')]
        .map((ref) => ref.isString ? ref.stringValue : null)
        .whereType<String>()
        .toList();
    var doc = (await Future.wait(sourceUris.map((uri) async {
          try {
            final read = uri.startsWith("http") ? (await Client().get(Uri.parse(uri))).body : File(uri).readAsStringSync();
            final doc = lang.parseString(read);
            return doc;
          } catch (e) {
            print(e);
            return null;
          }
        })))
            .reduce((value, element) => DocumentNode(definitions: [
                  if (value != null)
                    for (final def in value.definitions) def,
                  if (element != null)
                    for (final def in element.definitions) def,
                ])) ??
        DocumentNode();

    var typeNameMappers = <RegExp, String>{};
    var fieldNameMappers = <RegExp, String>{};
    if (!annotation.read('typeNameMappers').isNull) {
      typeNameMappers = annotation
          .read('typeNameMappers')
          .mapValue
          .map((key, value) => MapEntry(RegExp(key!.toStringValue()!), value!.toStringValue()!));
    }
    if (!annotation.read('fieldNameMappers').isNull) {
      fieldNameMappers = annotation
          .read('fieldNameMappers')
          .mapValue
          .map((key, value) => MapEntry(RegExp(key!.toStringValue()!), value!.toStringValue()!));
    }

    final result = SunnyGraphQLModel(
      className: concreteName,
      mixinMap: mixinMap,
      typeMap: typeMap,
      includes: includesSet.whereType<String>().map((pattern) => RegExp(pattern)).toList(),
      excludes: excludeSet.whereType<String>().map((pattern) => RegExp(pattern)).toList(),
      doc: doc,
      fieldNameMap: fieldNameMappers,
      typeNameMap: typeNameMappers,
    );

    doc.definitions.forEach((def) => result.addDefinition(def, forceInclude: false));
    return result;
  }

  SunnyGraphQLModel({
    required this.className,
    required this.mixinMap,
    required this.typeMap,
    required this.includes,
    required this.excludes,
    required this.doc,
    required this.typeNameMap,
    required this.fieldNameMap,
    this.mapTypeName = echo,
    this.mapFieldName = echo,
  });

  bool checkDone(String name) {
    if (!done.contains(name)) {
      done.add(name);
      return true;
    } else {
      return false;
    }
  }

  bool isIncluded(String name) {
    for (var pattern in excludes) {
      if (pattern.hasMatch(name)) {
        done.add(name);
        return false;
      }
    }
    return includes.isEmpty || includes.contains(name);
  }

  void addInputType(InputObjectTypeDefinitionNode def) {
    inputTypes[def.name.value] = def;
    addFragment(doc.findFragment("${def.toRawType()}Fragment"));
    def.fields.forEach((d) {
      addType(d.type, parentType: def.name.value);
    });
  }

  void addType(TypeNode node, {bool forceInclude = true, required String? parentType}) {
    if (node is ListTypeNode) {
      addType(node.type, forceInclude: forceInclude, parentType: parentType);
    } else if (node is NamedTypeNode) {
      final type = doc.findType(node);
      addDefinition(type, forceInclude: forceInclude);
    } else {
      addDefinition(node, forceInclude: forceInclude);
    }
  }

  void addFragment(Node? node, [List<String> from = const []]) {
    if (node is FragmentDefinitionNode) {
      var fragmentName = node.name.value;
      fragmentDepends.addType(fragmentName);
      from.forEach((f) {
        fragmentDepends.add(f, fragmentName);
        fragmentDepends.addAll(f, fragmentDepends.get(fragmentName));
      });
      if (fragments.containsKey(fragmentName)) {
        return;
      }
      fragments[fragmentName] = node;

      void inspectNode(SelectionSetNode? set) {
        set?.selections.forEach((sel) {
          if (sel is FragmentSpreadNode) {
            addFragment(doc.findFragment(sel.name.value), [...from, fragmentName]);
          } else if (sel is FieldNode) {
            inspectNode(sel.selectionSet);
          }
        });
      }

      inspectNode(node.selectionSet);
    }
  }

  void addObjectType(ObjectTypeDefinitionNode def) {
    objectTypes[def.name.value] = def;
    addFragment(doc.findFragment("${def.name.value}Fragment"));

    def.fields.forEach((d) {
      if (d.args.isEmpty) {
        addType(d.type, parentType: def.name.value);
      } else if (!d.name.value.endsWith('Connection')) {
        _log.info('Found a field with args: ${def.name.value}.${d.name.value}');
        var items = subqueries.putIfAbsent(def.name.value, () => {});
        items[d.name.value] = GraphSubQuery(
          object: def,
          field: d,
          parents: [],
        );
      }
    });
  }

  void addInterface(InterfaceTypeDefinitionNode def) {
    interfaceTypes[def.name.value] = def;
    def.fields.forEach((d) {
      addType(d.type, parentType: def.name.value);
    });
  }

  void addQuery(FieldDefinitionNode def) {
    query[def.name.value] = def;
    addType(def.type, parentType: null);
    def.args.forEach((element) => addType(element.type, parentType: def.type.toRawType()));
  }

  void addMutation(FieldDefinitionNode def) {
    mutation[def.name.value] = def;
    addType(def.type, parentType: null);
    def.args.forEach((element) => addType(element.type, parentType: def.type.toRawType()));
  }

  void addDefinition(Node? type, {bool forceInclude = true}) {
    if (type == null) return;
    if (type is ListTypeNode) {
      addType(type.type, forceInclude: forceInclude, parentType: null);
      return;
    }

    if (type is NamedTypeNode) {
      type = doc.findType(type);
    }

    if (type is InputObjectTypeDefinitionNode) {
      if (checkDone(type.name.value) && (forceInclude || isIncluded(type.name.value))) addInputType(type);
    } else if (type is ObjectTypeDefinitionNode) {
      if (type.name.value == 'Query') {
        type.fields
            .where((query) => checkDone(query.name.value) && isIncluded(query.name.value))
            .forEach((element) => addQuery(element));
      } else if (type.name.value == 'Mutation') {
        type.fields
            .where((query) => checkDone(query.name.value) && isIncluded(query.name.value))
            .forEach((element) => addMutation(element));
      } else {
        if (checkDone(type.name.value) && (forceInclude || isIncluded(type.name.value))) {
          addObjectType(type);
        }
      }
    } else if (type is EnumTypeDefinitionNode) {
      if (checkDone(type.name.value) && (forceInclude || isIncluded(type.name.value))) enumTypes[type.name.value] = type;
    } else if (type is InterfaceTypeDefinitionNode) {
      if (checkDone(type.name.value) && (forceInclude || isIncluded(type.name.value))) addInterface(type);
    } else if (type is FragmentDefinitionNode) {
      if (checkDone(type.name.value) && (forceInclude || isIncluded(type.name.value))) addFragment(type);
    } else if (type is ScalarTypeDefinitionNode) {
      checkDone(type.name.value);
    } else if (type is UnionTypeDefinitionNode) {
      checkDone(type.name.value);
      unionTypes[type.name.value] = type;
      type.types.forEach((unionType) {
        extraInterfaces.putIfAbsent(unionType.name.value, () => {}).add(
              NamedTypeNode(
                name: NameNode(value: (type as UnionTypeDefinitionNode).name.value),
              ),
            );
        var fragmentName = '${type.name.value}Fragment';
        UnionTypeDefinitionNode utype = type;
        if (utype.directives.hasDirective("selection")) {
          final prefix = utype.directives.getDirectiveValue("selection", "prefix").stringValue;
          final fields = utype.directives.getDirectiveValue("selection", "fields").getList<String>();
          var fragmentName = '${type.name.value}${prefix}Fragment';
          fragments.putIfAbsent(
            fragmentName,
            () => FragmentDefinitionNode(
              name: fragmentName.toNameNode(),
              typeCondition: TypeConditionNode(on: utype.name.value.toNamedType()),
              selectionSet: SelectionSetNode(selections: [
                for (final u in utype.types)
                  InlineFragmentNode(
                    typeCondition: TypeConditionNode(on: u),
                    selectionSet: SelectionSetNode(
                      selections: [
                        for (var field in fields) fieldNode(field),
                      ],
                    ),
                  )
              ]),
            ),
          );
          // fragmentDepends.addAll(fragmentName, utype.types.map((t) => "${t.name.value}Fragment").toSet());
        }
        fragments.putIfAbsent(
          fragmentName,
          () => FragmentDefinitionNode(
            name: fragmentName.toNameNode(),
            typeCondition: TypeConditionNode(on: utype.name.value.toNamedType()),
            selectionSet: SelectionSetNode(selections: [
              for (final u in utype.types)
                InlineFragmentNode(
                    typeCondition: TypeConditionNode(on: u),
                    selectionSet: SelectionSetNode(selections: [
                      FragmentSpreadNode(name: '${u.name.value}Fragment'.toNameNode()),
                    ]))
            ]),
          ),
        );
        fragmentDepends.addAll(fragmentName, utype.types.map((t) => "${t.name.value}Fragment").toSet());
      });
    } else if (type is DirectiveDefinitionNode) {
      // We ignore these on purpose
    } else {
      _log.warning('Skipping type ${type}');
    }
  }

  String fieldName(String fieldName) {
    var result = fieldName;
    fieldNameMap.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  String typeName(String typeName) {
    var result = typeName;
    typeNameMap.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  @override
  Iterable<TypeNode> getExtraInterfaces(String type) {
    return extraInterfaces[type] ?? const [];
  }

  @override
  String? getMixin(String type) {
    return mixinMap[type];
  }

  @override
  CodeBuilder toCode() {
    return buildGraphQLCode(this);
  }
}
