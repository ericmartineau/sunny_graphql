import 'package:flexidate/flexidate.dart';
import 'package:gql/ast.dart';
import 'package:gql/ast.dart' as ast;
import 'package:graphql/client.dart';
import 'package:dartxx/dartxx.dart';
import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_graphql/refs.dart';
import 'package:sunny_graphql/sunny_graphql_annotations.dart';
import 'package:sunny_sdk_core/mverse.dart';
import 'package:sunny_sdk_core/mverse/m_base_model.dart';
import 'package:sunny_sdk_core/data.dart';

part 'graphql_stuff.g.api.dart';
part 'graphql_stuff.g.impl.dart';
part 'graphql_stuff.g.meta.dart';

abstract class IRef {
  Uri? get photoUrl;
  String get displayName;
}

typedef FormatValue = dynamic;

abstract class IsContact {
  IRef get contact;
}

abstract class HasPhases {}

typedef EvaluationScore = Object;
typedef PlayerPosition = String;
typedef MetricLabels = List<String>;
mixin PlayerNodeMixin {}
final MyFragment = gql("""
fragment SuperSimpleRef on Ref {
  __typename
}
""").definitions.first as ast.FragmentDefinitionNode;

abstract class ContactApiMixin {}

abstract class TribeApiMixin {}

@graphQL(
  moduleName: 'reliveIt',
  uri: "./lib/schema.graphql",
  fragmentUri: './lib/fragments.graphql',
  typeMap: {
    'IRef': 'IRef',
    'IFact': 'IFact',
    'fd': 's1d33',
  },
  fieldNameMappers: fieldSuffixes,
  typeNameMappers: typeNameMap,
  fragments: ['MyFragment'],
  excludes: const [
    '.*Count\$',
  ],
)
abstract class _GraphQLStuff {}

mixin ISpecialEventMixin {}
mixin PhaseServiceMixin {}

abstract class Phased {}

mixin IFactMixin {}
mixin IFactInputMixin {}
mixin IMemoryInputMixin {}
mixin ISpecialEventInputMixin {}
mixin ClipMixin {}
mixin IMemoryMixin {}

abstract class ITribeInput {}

abstract class HasPhasesInputMixin {}

abstract class HasMemoriesInputMixin {}

abstract class IPhase {}

abstract class IFact {}

abstract class IMemory {}

mixin FactMixin implements Entity {}

abstract class HasPhasesApi {}

mixin HasFactsApi {}
mixin HasFacts {}

abstract class HasPhasesMixin implements HasPhases {}

abstract class HasMemories implements Entity {}

abstract class HasMemoriesApi {}

abstract class HasMemoriesMixin implements HasMemories {}

abstract class HasMemoriesCreateInput implements GraphInput {}

abstract class HasMemoriesUpdateInput implements GraphInput {}

abstract class HasContacts {}

abstract class HasTribes {}

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
