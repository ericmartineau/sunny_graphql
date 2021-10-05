import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'graphql_generator.dart';

Builder sunnyGraphQL(BuilderOptions options) => SharedPartBuilder([GraphQLGenerator()], 'graphql');
