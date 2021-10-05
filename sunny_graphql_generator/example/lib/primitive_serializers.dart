import 'package:sunny_graphql/graph_client_serialization.dart';
import 'package:sunny_sdk_core/api_exports.dart';

class ReliveItGraphQLSerializers {
  static EntityReader? primitiveReader(String typeName) {
    switch (typeName) {
      case 'Uri':
        return (input) => Uri.parse(input.toString());
      case 'FlexiDate':
        print("Flex");
        return (input) => FlexiDate.fromJson(input);
      default:
        return null;
    }
  }

  static EntityWriter? primitiveWriter(String typeName) {
    return (data) {
      if (data is Uri) {
        return data.toString();
      } else if (data is FlexiDate) {
        return data.toJson();
      } else {
        return data;
      }
    };
  }
}
