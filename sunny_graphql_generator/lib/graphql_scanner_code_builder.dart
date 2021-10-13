import 'package:code_builder/code_builder.dart';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart';
import 'package:logging/logging.dart';
import 'package:sunny_graphql_generator/shared.dart';

import 'code_builder.dart';
import 'model.dart';
import 'shared_code_builders.dart';

buildSerializer(GraphQLScanResult model, CodeBuilder code) {
  _log.info('Writing Concrete Class');
  code += [
    'class ${model.className}Json {',
    '  EntityReader? getReader(name) {',
    '    switch(name) {',
    for (var model in [
      ...model.inputTypes.values.map((model) => model.name.value),
      ...model.objectTypes.values.map((model) => model.name.value),
      ...model.enumTypes.values.map((model) => model.name.value),
    ])
      '      case "${model}": return (_) => ${model}.fromJson(_);',
    '      default: return null;'
        '    }',
    '  }',
    '',
    '  EntityWriter? getWriter(name) {',
    '    switch(name) {',
    for (var model in [
      ...model.inputTypes.values.map((model) => model.name.value),
      ...model.objectTypes.values.map((model) => model.name.value),
      ...model.enumTypes.values.map((model) => model.name.value),
    ])
      '      case "${model}": return (from) => from?.toJson();',
    '      default: return null;',
    '    }',
    '  }',
    '}',
    '',
  ];
}

final _log = Logger('graph_scanner');
CodeBuilder buildGraphQLCode(GraphQLScanResult model) {
  final query = model.query;
  final mutation = model.mutation;
  final concreteName = model.className;

  var code = CodeBuilder();
  code += Field((f) => f
    ..name = '_nullDefaultValue'
    ..modifier = FieldModifier.constant
    ..assignment = Code("const DefaultValueNode(value: null)"));

  _log.info('Writing Operations');

  var allOperations = {'query': query.values, 'mutation': mutation.values};
  code += Class(
    (c) => c
      ..name = 'I${concreteName}'
      ..abstract = true
      ..methods.addAll([
        for (var operation in allOperations.values.expand((e) => e))
          Method((m) => m
            ..name = operation.name.value
            ..returns = refer('Future<${operation.type.toDartType()}>')
            ..body = null
            ..optionalParameters.addAll(
              operation.args.map(
                (p) => p.toParameter(),
              ),
            )),

        // ..requiredParameters = Future<${operation.type.toDartType()}>
        // ${operation.name.value}(${opParamDeclaration(doc, operation.args)});',
      ]),
  );

  model.addAllModels(code);

  _log.info('Writing Class');
  code += [
    'class ${concreteName} extends _${concreteName} implements I${concreteName} {',
    '  final GraphQLClientGetter client;',
    '  final GraphSerializer serializer;',
    '  ${concreteName}({GraphQLClientGetter? client, GraphSerializer? serializer,}):',
    '       client = client ?? (()=>GraphClientConfig.client),',
    '       serializer = serializer ?? FactoryGraphSerializer()',
    ';',
    '',
  ];

  _log.info('Writing Operation Schemas');
  for (var set in allOperations.entries) {
    for (var query in set.value) {
      code += [
        """
  static const ${query.name.value}Op = const OperationDefinitionNode(
    type: OperationType.${set.key.toLowerCase()},
    name: NameNode(value: "${query.name.value}"),
    variableDefinitions: [
    """,
        for (var variable in query.args)
          """
      VariableDefinitionNode(
        variable: VariableNode(
            name: NameNode( value: "${variable.name.value}"),
          ),
          defaultValue: _nullDefaultValue,
          type: NamedTypeNode(
            name: NameNode(
                value: '${variable.type.toGQLType()}'
              ),
            isNonNull: ${variable.type.isNonNull}, 
        ),
      ),                     
            """,
        """
    ],
    selectionSet: SelectionSetNode(
      selections: [
        FieldNode(
            name: NameNode(value: "${query.name.value}"),
            arguments: [""",
        for (var arg in query.args)
          '            ArgumentNode(name: NameNode(value: "${arg.name.value}"), value: VariableNode(name: NameNode(value: "${arg.name.value}"))),',
        """
            ],
            selectionSet: SelectionSetNode(selections: [
              ${query.type.toSelectionNode(model.doc)}
            ],
          ),
        )
      ],
    ),
  );
  """,
        '',
        '  @override',
        '  Future<${query.type.toDartType()}> ${query.name.value}(${opParamDeclaration(model.doc, query.args)}) async {',
        """
      var result = await this.client().queryManager.${set == 'query' ? 'query(Query' : 'mutate(Mutation'}Options(
                              document: DocumentNode(definitions: [${query.name.value}Op, ${model.fragmentDepends.getAll(query).join(',')}]),
                              operationName: "${query.name.value}",
                              variables: {${opParams(model.doc, query.args)}}));
        
      if (result.hasException) {
        throw result.exception!;
      }
      
      return this.serializer.read${query.type is ListTypeNode ? 'List' : ''}(result.data!["${query.name.value}"], typeName: "${query.type.toRawType()}", isNullable: ${!query.type.isNonNull});
                """,
        '  }',
      ];
    }
  }
  code += '}';

  buildSerializer(model, code);
  _log.info('Writing Subqueries');
  model.subqueries.forEach((objName, q) {
    code += Class((c) => c
      ..name = '${objName.capitalize()}Api'
      ..abstract = true
      ..methods.addAll([
        for (var sub in q.values)
          Method((m) => m
            ..name = 'load${sub.field.name.value.capitalize()}'
            ..optionalParameters.addAll(sub.field.args.map((a) => a.toParameter()))),
      ]));
  });
  _log.info('Done!');
  return code;
}

String opParams(DocumentNode doc, List<InputValueDefinitionNode> args) {
  String str = '';
  args.forEach((arg) {
    str +=
        '    "${arg.name.value}": this.serializer.write(${arg.name.value}, typeName: "${arg.type.toRawType()}", isList: ${arg.type is ListTypeNode},),';
  });
  return str;
}

String opParamDeclaration(DocumentNode doc, List<InputValueDefinitionNode> args) {
  String str = '';
  args.forEach((arg) {
    str += '    ${arg.type.isNonNull ? 'required ' : ''} ${arg.type.toDartType()} ${arg.name.value},';
  });
  return str.isNotEmpty ? '{ ${str} }' : '';
}
