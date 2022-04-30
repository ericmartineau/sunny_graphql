import 'package:dartxx/json_path.dart';
import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_sdk_core/api_exports.dart';
import 'package:sunny_sdk_core/mverse.dart';

mixin HasGraphMeta {
  EntityMeta get meta;
  MSchemaRef get mtype => meta.mtype;
  Set<String> get mfields => meta.fields;
  List<JsonPath> get mpaths => meta.paths;
}

class EntityMeta {
  final MSchemaRef mtype;
  final Set<String> fields;
  final List<JsonPath> paths;

  const EntityMeta(this.fields, this.paths, this.mtype);
}
