import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_graphql/sunny_graphql_annotations.dart';
import 'package:sunny_graphql_generator/graphql_neo4j_code_builder.dart';
import 'package:sunny_graphql_generator/graphql_neo4j_scanner.dart';

final _log = Logger('graph_generator');

class GraphQLGenerator extends GeneratorForAnnotation<graphQL> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    _log.info('Reading data');
    GraphQLNeo4Model model;
    model = await GraphQLNeo4Model.fromAnnotation(element, annotation);
    final code = buildNeo4jCode(model);
    return code.toString();
  }
}
