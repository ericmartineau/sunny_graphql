import 'package:gql/ast.dart';
import 'package:inflection3/inflection3.dart';
import 'package:sunny_graphql_generator/shared.dart';

enum GraphOpType { create, update, delete, list, count }

///
/// Represents a neo4j graphQL entity.  We attempt to extract the relationships and stuff to generate something
/// that's more like what we want, less like the raw graphQL schema
class GraphQLEntity {
  final String name;
  String get namePlural => pluralize(name);
  final List<FieldDefinition> fields = [];
  final List<String> mixins = [];
  final List<String> serviceMixins = [];
  final List<String> serviceInterfaces = [];
  final Set<GraphOpType> ops = {};

  GraphQLEntity(this.name);

  bool get hasLazyQueries => fields.any((f) => f.isLazy);

  FieldDefinition getField(String value) {
    return fields.where((f) => f.name == value).first;
  }
}

class GraphQLRelation {
  final String fieldName;
  final String belongsTo;
  final bool isLazy;
  final bool isEager;
  final String? propsType;
  final String? joinTypeName;

  GraphQLRelation({
    required this.belongsTo,
    required this.fieldName,
    required this.isLazy,
    required this.isEager,
    required this.propsType,
    required this.joinTypeName,
  });
}
