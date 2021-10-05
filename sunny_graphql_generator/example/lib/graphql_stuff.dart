import 'package:flexidate/flexidate.dart';
import 'package:gql/ast.dart';
import 'package:graphql/client.dart';
import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_graphql/refs.dart';
import 'package:sunny_graphql/sunny_graphql_annotations.dart';
import 'package:sunny_sdk_core/mverse.dart';

part 'graphql_stuff.g.dart';

abstract class IRef {
  Uri? get photoUrl;
  String get displayName;
}

@graphQL(
  moduleName: 'reliveIt',
  uri: "./lib/schema.graphql",
  fragmentUri: './lib/fragments.graphql',
  typeMap: {
    'IRef': 'IRef',
    'fd': '132',
  },
  fieldNameMappers: fieldSuffixes,
  typeNameMappers: typeNameMap,
  excludes: const [
    '.*Count\$',
  ],
)
abstract class _GraphQLStuff {}

abstract class HasPhases implements Entity {}

abstract class HasPhasesCreateInput implements GraphInput {}

abstract class HasPhasesUpdateInput implements GraphInput {}

abstract class TribeData {}

typedef GraphQLClientGetter = GraphQLClient Function();

const fieldSuffixes = {
  '_NOT_CONTAINS\$': 'DoesNotContain',
  '_NOT_STARTS_WITH\$': 'DoesNotStartWith',
  '_NOT_ENDS_WITH\$': 'DoesNotEndWith',
  '_STARTS_WITH\$': 'StartsWith',
  '_ENDS_WITH\$': 'EndsWith',
  '_NOT_IN\$': 'IsNotIn',
  '_CONTAINS\$': 'Contains',
  '_IN\$': 'IsIn',
  '_NOT\$': 'IsNot',
};

const typeNameMap = {
  'Where\$': 'Filters',
};
