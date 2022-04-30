import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_graphql_generator/graphql_meta_generator.dart';

import 'graphql_api_generator.dart';
import 'graphql_generator.dart';

Builder sunnyGraphQLImplementation(BuilderOptions options) =>
    PartBuilder([GraphQLGenerator()], '.g.impl.dart');
Builder sunnyGraphQLAPI(BuilderOptions options) =>
    PartBuilder([GraphQLApiGenerator()], '.g.api.dart');
Builder sunnyGraphQLMeta(BuilderOptions options) =>
    PartBuilder([GraphQLMetaGenerator()], '.g.meta.dart');
