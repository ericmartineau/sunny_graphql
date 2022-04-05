import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:gql/ast.dart' as ast;
import 'package:gql/ast.dart';
import 'package:inflection3/inflection3.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_dart/helpers/strings.dart';
import 'package:sunny_graphql_generator/graphql_entity.dart';
import 'package:sunny_graphql_generator/model.dart';
import 'package:sunny_graphql_generator/sunny_graphql_model.dart';

import '../shared.dart';
import '../shared.dart' as shared;

final _log = Logger('graphQLScanner');

typedef NameMapper = String Function(String input);

String echo(String input) => input;

class GraphQLNeo4Model {
  final String moduleName;
  final SunnyGraphQLModel model;
  final List<String> externalFragments = [];
  final Map<String, GraphQLEntity> entities = {};
  final Map<RegExp, String> typeNameMappers;
  final Map<RegExp, String> fieldNameMappers;

  GraphQLNeo4Model(this.moduleName, this.model, {required this.typeNameMappers, required this.fieldNameMappers});

  static Future<GraphQLNeo4Model> fromAnnotation(Element element, ConstantReader annotation) async {
    final model = await SunnyGraphQLModel.initFromAnnotation(element, annotation);
    Map<RegExp, String> typeNameMappers = {};
    Map<RegExp, String> fieldNameMappers = {};
    String moduleName = 'models';
    List<String> externalFragments = [];
    if (annotation.read('fragments').isList) {
      externalFragments = [
        for (var v in annotation.read('fragments').listValue) v.toStringValue()!,
      ];
    }
    if (annotation.read('moduleName').isString) {
      moduleName = annotation.read('moduleName').stringValue;
    }
    if (!annotation.read('typeNameMappers').isNull) {
      typeNameMappers = annotation
          .read('typeNameMappers')
          .mapValue
          .map((key, value) => MapEntry(RegExp(key!.toStringValue()!), value!.toStringValue()!));
    }
    if (!annotation.read('fieldNameMappers').isNull) {
      fieldNameMappers = annotation
          .read('fieldNameMappers')
          .mapValue
          .map((key, value) => MapEntry(RegExp(key!.toStringValue()!), value!.toStringValue()!));
    }
    final neo4jModel = GraphQLNeo4Model(
      moduleName,
      model,
      fieldNameMappers: fieldNameMappers,
      typeNameMappers: typeNameMappers,
    );

    model.doc.definitions
        .whereType<ObjectTypeDefinitionNode>()
        .where((def) => def.directives.any((element) => element.name.value == 'entity'))
        .forEach((def) {
      var name = def.name.value;
      var entity = GraphQLEntity(name);
      var ops = {...GraphOpType.values};
      final exclude = def.directives.getDirective('exclude');
      if (exclude != null) {
        if (exclude.arguments.isEmpty) {
          ops.removeAll(GraphOpType.values);
        } else {
          exclude.arguments.forEach((arg) {});
        }
      }

      final mixinNames = def.directives.mixinNames;
      final serviceMixinNames = def.directives.mixinApiNames;
      final serviceInterfaceNames = def.directives.interfaceApiNames;
      entity.mixins.addAll(mixinNames);
      entity.serviceMixins.addAll(serviceMixinNames);
      entity.serviceInterfaces.addAll(serviceInterfaceNames);

      entity.ops.addAll(ops);
      entity.fields.addAll(def.fields.map((fieldDefinition) {
        // final relationship = fieldDefinition.directives.where((directive) => directive.name.value == 'relationship').firstOr();

        final fieldDef = FieldDefinition.ofField(
          model,
          fieldDefinition,
          entityName: def.name.value,
        );

        final relation = fieldDef.relationship;
        if (relation?.eagerPrefix != null) {
          // Create union
        }

        if (relation?.propsType != null) {
          // neo4j graphql convention
          final relationFieldType = '${entity.name}${capitalize(fieldDefinition.name.value)}Connection';
          final mappedFieldType = fieldDefinition.type.toRawType();
          final propsType = model.doc.findByName<ast.InterfaceTypeDefinitionNode>(relation!.propsType!)!;
          final relationType = fieldDef.joinRecordType ?? relation.propsType;
          model.fragments['${relationType}Fragment'] = ast.FragmentDefinitionNode(
              name: "${relationType}Fragment".toNameNode(),
              typeCondition: ast.TypeConditionNode(on: relationFieldType.toNamedType()),
              selectionSet: ast.SelectionSetNode(selections: [
                FieldNode(
                  name: "edges".toNameNode(),
                  selectionSet: ast.SelectionSetNode(selections: [
                    ast.FieldNode(
                      name: 'node'.toNameNode(),
                      selectionSet: ast.SelectionSetNode(
                        selections: [
                          ast.FragmentSpreadNode(name: '${fieldDefinition.type.toRawType()}Fragment'.toNameNode()),
                        ],
                      ),
                    ),
                    ...propsType.fields.map((f) => ast.FieldNode(name: f.name)),
                  ]),
                ),
              ]));
          if (!fieldDefinition.isLazy) {
            model.fragmentDepends.add('${entity.name}Fragment', '${relationType}Fragment');
          }
          model.fragmentDepends.add('${relationType}Fragment', '${fieldDefinition.type.toRawType()}Fragment');
          // We need to add a custom join type.
          final name = buildJoinRecordName(def.name.value, fieldDefinition.name.value);
          // Use the more lax Entity for the T2 type parameter. This makes it much easier to dynamically set lists without getting
          // casting errors.  The lists can be pretty easily cast on the way out.
          model.typedefs[name] = 'JoinRecord<$mappedFieldType, Entity, ${propsType.name.value}>';
          model.joinRecords.add(propsType.name.value);

          // model.addDefinition(
          //   ast.ObjectTypeDefinitionNode(
          //     name: NameNode(value: relation.propsType!),
          //     directives: [
          //       directiveNode('joinRecord', args: {
          //         'nodeType': mappedFieldType,
          //       }),
          //     ],
          //     // interfaces: [
          //     //   NamedTypeNode(
          //     //     name: NameNode(value: '${relation.propsType!}<${fieldDefinition.type.toRawType()}>'),
          //     //   ),
          //     //   NamedTypeNode(name: NameNode(value: "JoinTypeMixin<${fieldDefinition.type.toRawType()}>")),
          //     // ],
          //     fields: [
          //       FieldDefinitionNode(
          //         name: NameNode(value: "node"),
          //         type: NamedTypeNode(
          //             name: NameNode(
          //           value: fieldDefinition.type.toRawType(),
          //         )),
          //       ),
          //       ...propsType.fields.where((element) {
          //         return !(['timestamp', 'exclude', 'ignore']
          //             .any((directiveName) => element.directives.hasDirective(directiveName)));
          //       }),
          //     ],
          //   ),
          // );
        }

        return fieldDef;
      }));

      var mappedFields = def.fields.map((fieldDefinition) {
        var entityField = entity.fields.firstWhere((element) => element.name == fieldDefinition.name.value);

        var propsName = entityField.relationship?.propsType;
        if (propsName != null) {
          final mappedType = entityField.isList
              ? ast.ListTypeNode(
                  type: entityField.joinRecordType!.toNamedType(isNonNull: true),
                  isNonNull: fieldDefinition.type.isNonNull,
                )
              : entityField.joinRecordType!.toNamedType();
          return ast.FieldDefinitionNode(
            name: entityField.name.toNameNode(),
            type: mappedType,
            directives: fieldDefinition.directives,
            args: fieldDefinition.args,
            description: fieldDefinition.description,
            span: fieldDefinition.span,
          );
        } else {
          return fieldDefinition;
        }
      }).toList();

      def.fields.clear();
      def.fields.addAll(mappedFields);
      neo4jModel._addEntity(entity);
      neo4jModel.entities[entity.name] = entity;
    });

    // Go back over the models, and add eager join selections to the fragment definitions.  These eager joins cannot be added to
    // the source model since they don't technically exist until runtime.
    neo4jModel.entities.values.forEach((entity) {
      var relatedFields = entity.fields.where((field) => field.isRelationship && field.isEager).toList();
      if (relatedFields.isNotEmpty) {
        // final frag = neo4jModel.model.fragments['${entity.name}Fragment'];
        // if (frag == null) {
        //   _log.warning("MISSING FRAGMENT for ${entity.name}, which has eager joinType fields");
        // } else {
        for (var relatedField in relatedFields) {
          final frag = neo4jModel.model.fragments['${entity.name}Fragment'];
          if (frag == null) {
            _log.warning("MISSING FRAGMENT for ${entity.name}, which has eager joinType fields");
          } else {
            frag.selectionSet.selections
                .removeWhere((element) => element is ast.FieldNode && element.name.value == relatedField.name);
            late String fieldNodeName;
            late String fieldFragmentName;

            if (relatedField.joinRecordType != null) {
              fieldNodeName = '${relatedField.name}Connection';
              fieldFragmentName = '${entity.name}${capitalize(singularize(relatedField.name))}';
            } else {
              fieldNodeName = '${relatedField.name}';
              fieldFragmentName = '${relatedField.eagerPrefix ?? ''}${relatedField.typeNode.toGQLType(withNullability: false)}';
            }
            frag.selectionSet.selections.add(
              fieldNode(
                fieldNodeName,
                selectionSet: ['...${fieldFragmentName}Fragment'],
              ),
            );
          }
        }
      }
    });

    neo4jModel.externalFragments.addAll(externalFragments);
    return neo4jModel;
  }

  void _addEntity(GraphQLEntity entity) {
    final name = entity.name;

    final objectDefinition =
        model.doc.definitions.whereType<ObjectTypeDefinitionNode>().where((element) => element.name.value == entity.name).first;

    model.objectTypes[entity.name] = objectDefinition;
    model.addFragment(model.doc.findFragment("${objectDefinition.name.value}Fragment"));

    objectDefinition.fields.forEach((fieldDefinition) {
      final eField = entity.getField(fieldDefinition.name.value);

      model.addType(eField.typeNode, parentType: objectDefinition.name.value);
    });

    var inputFields = [
      for (var field in entity.fields)
        if (field.canCreate)
          if (field.isRelationship)
            InputValueDefinitionNode(
              directives: [
                directiveNode('ref', args: {
                  'alias': field.relationRefType(),
                }),
                if (field.isList)
                  directiveNode('reflist', args: {
                    'alias': field.relationSingularRefType(),
                    'target': field.singularRefType,
                  }),
              ],
              name: NameNode(value: field.name),
              type: field.relationRefAlias().toNamedType(),
            )
          else
            InputValueDefinitionNode(
              name: NameNode(value: field.name),
              type: field.typeNode,
            ),
    ];
    model.addDefinition(
        InputObjectTypeDefinitionNode(
          name: NameNode(value: '${name}CreateInput'),
          fields: inputFields,
          directives: objectDefinition.directives,
        ),
        forceInclude: true);
    model.addDefinition(
        InputObjectTypeDefinitionNode(
          name: NameNode(value: '${name}UpdateInput'),
          fields: inputFields,
          directives: objectDefinition.directives,
        ),
        forceInclude: true);
  }
}

String buildJoinRecordName(String containerName, String fieldName) {
  return '$containerName${capitalize(singularize(fieldName))}';
}
