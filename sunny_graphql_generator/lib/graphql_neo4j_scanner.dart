import 'dart:async';

// import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:dartxx/dartxx.dart';
import 'package:gql/ast.dart' as ast;
import 'package:gql/ast.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sunny_graphql_generator/graphql_entity.dart';
import 'package:sunny_graphql_generator/sunny_graphql_model.dart';

import 'shared.dart';
import 'shared.dart' as shared;

final _log = Logger('graphQLScanner');

typedef NameMapper = String Function(String input);

String echo(String input) => input;

class GraphQLNeo4Model {
  final String moduleName;
  final SunnyGraphQLModel model;
  final Map<String, GraphQLEntity> entities = {};
  final Map<RegExp, String> typeNameMappers;
  final Map<RegExp, String> fieldNameMappers;

  GraphQLNeo4Model(this.moduleName, this.model, {required this.typeNameMappers, required this.fieldNameMappers});

  static Future<GraphQLNeo4Model> fromAnnotation(Element element, ConstantReader annotation) async {
    final model = await SunnyGraphQLModel.initFromAnnotation(element, annotation);
    Map<RegExp, String> typeNameMappers = {};
    Map<RegExp, String> fieldNameMappers = {};
    String moduleName = 'models';
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

    void addEntity(GraphQLEntity entity) {
      final name = entity.name;

      final objectDefinition =
          model.doc.definitions.whereType<ObjectTypeDefinitionNode>().where((element) => element.name.value == entity.name).first;

      model.objectTypes[entity.name] = objectDefinition;
      model.addFragment(model.doc.findFragment("${objectDefinition.name.value}Fragment"));

      objectDefinition.fields.forEach((fieldDefinition) {
        final eField = entity.getField(fieldDefinition.name.value);

        model.addType(eField.typeNode, parentType: objectDefinition.name.value);
      });

      model.addDefinition(
          InputObjectTypeDefinitionNode(name: NameNode(value: '${name}CreateInput'), fields: [
            for (var field in entity.fields)
              if (field.canCreate)
                if (field.isRelationship)
                  InputValueDefinitionNode(
                    name: NameNode(value: field.name),
                    type: NamedTypeNode(
                      name: NameNode(
                        value: field.relationRefType(),
                      ),
                    ),
                  )
                else
                  InputValueDefinitionNode(
                    name: NameNode(value: field.name),
                    type: field.typeNode,
                  ),
          ]),
          forceInclude: true);
      model.addDefinition(
          InputObjectTypeDefinitionNode(name: NameNode(value: '${name}UpdateInput'), fields: [
            for (var field in entity.fields)
              if (field.canUpdate)
                if (field.isRelationship)
                  InputValueDefinitionNode(
                    name: NameNode(value: field.name),
                    type: NamedTypeNode(name: NameNode(value: field.relationRefType())),
                  )
                else
                  InputValueDefinitionNode(
                    name: NameNode(value: field.name),
                    type: field.typeNode,
                  ),
          ]),
          forceInclude: true);
    }

    model.doc.definitions
        .whereType<ObjectTypeDefinitionNode>()
        .where((def) => def.directives.any((element) => element.name.value == 'entity'))
        .forEach((def) {
      var name = def.name.value;
      var entity = GraphQLEntity(name);
      var ops = {...GraphOpType.values};
      def.directives.where((element) => element.name.value == 'exclude').forEach((exclude) {
        if (exclude.arguments.isEmpty) {
          ops.removeAll(GraphOpType.values);
        } else {
          exclude.arguments.forEach((arg) {});
        }
      });

      entity.ops.addAll(ops);
      entity.fields.addAll(def.fields.map((fieldDefinition) {
        final relationship = fieldDefinition.directives.where((directive) => directive.name.value == 'relationship').firstOr();
        final named = fieldDefinition.directives.where((directive) => directive.name.value == 'named').firstOr();

        final relation = (relationship == null)
            ? null
            : GraphQLRelation(
                belongsTo: def.name.value,
                fieldName: fieldDefinition.name.value,
                isLazy: fieldDefinition.isLazy,
                isEager: fieldDefinition.isEager,
                joinTypeName:
                    named?.arguments.where((arg) => arg.name.value == 'name').map((arg) => arg.value.stringValue).firstOr(),
                propsType: relationship.arguments
                    .where((arg) => arg.name.value == 'properties')
                    .map((arg) => arg.value.stringValue)
                    .firstOr(),
              );

        if (relation?.joinTypeName != null) {
          final interface = model.doc.findByName<ast.InterfaceTypeDefinitionNode>(relation!.propsType!)!;
          // We need to add a custom join type.
          model.addDefinition(
            ast.ObjectTypeDefinitionNode(
              name: NameNode(value: relation.joinTypeName!),
              directives: [ast.DirectiveNode(name: "joinRecord".toNameNode())],
              interfaces: [
                NamedTypeNode(
                  name: NameNode(value: relation.propsType!),
                ),
                NamedTypeNode(name: NameNode(value: "JoinTypeMixin<${fieldDefinition.type.toRawType()}>")),
              ],
              fields: [
                FieldDefinitionNode(
                  name: NameNode(value: "node"),
                  type: NamedTypeNode(
                      name: NameNode(
                    value: fieldDefinition.type.toRawType(),
                  )),
                ),
                ...interface.fields,
              ],
            ),
          );
        }
        return FieldDefinition.ofField(
          model,
          fieldDefinition,
          relationship: relation,
        );
      }));

      var mappedFields = def.fields.map((fieldDefinition) {
        var entityField = entity.fields.firstWhere((element) => element.name == fieldDefinition.name.value);

        var propsName = entityField.relationship?.joinTypeName;
        if (propsName != null) {
          final mappedType = entityField.isList
              ? ast.ListTypeNode(
                  type: propsName.toNamedType(),
                  isNonNull: fieldDefinition.type.isNonNull,
                )
              : propsName.toNamedType();
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
      addEntity(entity);
      neo4jModel.entities[entity.name] = entity;
    });

    return neo4jModel;
  }
}

extension StringToNode on String {
  NamedTypeNode toNamedType({bool isNonNull = true}) => ast.NamedTypeNode(
        name: this.toNameNode(),
        isNonNull: isNonNull,
      );
  NameNode toNameNode() => ast.NameNode(value: this);
}
