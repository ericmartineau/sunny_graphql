library sunny_graphql_annotations;

class graphQL {
  final String? uri;
  final String? fragmentUri;
  final String? declaration;
  final List<String>? includes;
  final List<String>? excludes;
  final Map<String, String> mixins;
  final Map<String, String> typeMap;
  final Map<String, String> fieldNameMappers;
  final Map<String, String> typeNameMappers;
  final List fragments;
  final String? moduleName;

  const graphQL({
    this.uri,
    this.moduleName,
    this.includes,
    this.mixins = const {},
    this.typeMap = const {},
    this.fieldNameMappers = const {},
    this.typeNameMappers = const {},
    this.fragments = const [],
    this.excludes,
    this.fragmentUri,
    this.declaration,
  });
}
