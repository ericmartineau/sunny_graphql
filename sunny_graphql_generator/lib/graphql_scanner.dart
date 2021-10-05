import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_graphql_generator/sunny_graphql_model.dart';
import 'package:sunny_graphql_generator/model.dart';

class DefaultGraphModelLoader {
  Future<GraphQLScanResult> loadGraphModels(Element element, ConstantReader annotation) async {
    final model = await SunnyGraphQLModel.initFromAnnotation(element, annotation);
    model.doc.definitions.forEach((def) => model.addDefinition(def, forceInclude: false));
    return model;
  }
}
