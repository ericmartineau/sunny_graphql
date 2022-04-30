import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_graphql/sunny_graphql_annotations.dart';
import 'package:sunny_graphql_generator/neo4j/graphql_neo4j_code_builder.dart';
import 'package:sunny_graphql_generator/neo4j/graphql_neo4j_meta_builder.dart';
import 'package:sunny_graphql_generator/neo4j/graphql_neo4j_scanner.dart';

final _log = Logger('graph_generator');

class GraphQLMetaGenerator extends GeneratorForAnnotation<graphQL> {
  @override
  dynamic generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    _log.info('Reading data');
    GraphQLNeo4Model model;
    model = await GraphQLNeo4Model.fromAnnotation(element, annotation);
    final code = buildNeo4jCodeMeta(model);
    return code.toString();
  }
}
