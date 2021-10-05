import 'package:gql/ast.dart';
import 'package:logging/logging.dart';

import 'shared.dart';

abstract class GraphQLScanResult {
  String get className;
  Map<String, FieldDefinitionNode> get query;
  Map<String, FieldDefinitionNode> get mutation;
  Map<String, ObjectTypeDefinitionNode> get objectTypes;
  Map<String, InterfaceTypeDefinitionNode> get interfaceTypes;
  Map<String, InputObjectTypeDefinitionNode> get inputTypes;
  Map<String, EnumTypeDefinitionNode> get enumTypes;
  Map<String, String> get typeMap;
  Map<String, Map<String, GraphSubQuery>> get subqueries;
  String? getMixin(String type);
  Iterable<TypeNode> getExtraInterfaces(String type);
  String fieldName(String input);
  String typeName(String input);
  DocumentNode get doc;
  Map<String, FragmentDefinitionNode> get fragments;
  FragmentDependencies get fragmentDepends;

  Logger get log;
}

class GraphSubQuery {
  final ObjectTypeDefinitionNode object;
  final FieldDefinitionNode field;
  final List<FieldDefinitionNode> parents;

  const GraphSubQuery({required this.parents, required this.object, required this.field});
}

extension GraphQLScanResultExt on GraphQLScanResult {
  Iterable<ObjectTypeDefinitionNode> get declaredObjectTypes =>
      objectTypes.values.where((def) => !typeMap.containsKey(def.name.value));

  Iterable<InterfaceTypeDefinitionNode> get declaredInterfaceTypes =>
      interfaceTypes.values.where((def) => !typeMap.containsKey(def.name.value));

  Iterable<InputObjectTypeDefinitionNode> get declaredInputTypes =>
      inputTypes.values.where((def) => !typeMap.containsKey(def.name.value));

  Iterable<EnumTypeDefinitionNode> get declaredEnumTypes => enumTypes.values.where((def) => !typeMap.containsKey(def.name.value));
}

class FragmentDependencies {
  final _dependencies = <String, Set<String>>{};

  void addType(String type) {
    _dependencies.putIfAbsent(type, () => {});
  }

  void add(String type, String dependency) {
    _dependencies.putIfAbsent(type, () => {}).add(dependency);
  }

  void addAll(String type, Set<String> dependencies) {
    _dependencies.putIfAbsent(type, () => {}).addAll(dependencies);
  }

  Set<String> self(String type) {
    var fragmentName = "${type}Fragment";
    return {
      if (_dependencies.containsKey(fragmentName)) fragmentName,
      if (_dependencies.containsKey(type)) type,
    };
  }

  Set<String> get(String type) {
    return {
      ...?_dependencies[type],
      ...?_dependencies["${type}Fragment"],
    };
  }

  Set<String> operator [](String type) {
    return {
      ...this.self(type),
      ...?_dependencies[type],
      ...?_dependencies["${type}Fragment"],
    };
  }

  Set<String> getAll(FieldDefinitionNode? query) {
    if (query == null) return {};
    final allFragments = {
      ...self(query.type.toRawType()),
      ...get(query.type.toRawType()),
      ...query.args.expand((a) => get(a.type.toRawType()))
    };
    return allFragments;
  }
}
