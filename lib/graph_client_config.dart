import 'package:graphql_flutter/graphql_flutter.dart';

import 'graph_client_serialization.dart';

typedef GraphQLClientGetter = GraphQLClient Function();

class GraphClientConfig {
  static GraphQLClientGetter? _client;

  static GraphQLClient get client => _client?.call() ?? (throw "No graphQL client was intialized.  Use GraphQuery.init()");

  static GraphSerializer? _serializer;

  // = (input, name, isList, isNullable) => input;

  static init(GraphQLClient client, {GraphSerializer? serializer}) {
    _client = () => client;
    _serializer = serializer ?? _serializer;
  }

  static initGetter(GraphQLClientGetter client, {
    GraphSerializer? serializer,
  }) {
    _client = client;
    _serializer = serializer ?? _serializer;
  }

  static T read<T>(dynamic input, {required String typeName, required bool isNullable}) {
    return _serializer!.read(input, typeName: typeName, isNullable: isNullable) as T;
  }

  static List<T> readList<T>(dynamic input, {required String typeName, required bool isNullable}) {
    return _serializer!.readList<T>(input, typeName: typeName, isNullable: isNullable);
  }

  static write(dynamic input, {required String typeName, required bool isList}) {
    return _serializer!.write(input, typeName: typeName, isList: isList);
  }

  ///
  /// Retrieves a
  static getDeep(json, [f1, f2, f3]) {
    var res = json;
    if (json == null) return null;

    for (var f in [if(f1 != null)f1, if(f2 != null) f2, if(f3 != null)f3]) {
      try {
        res = res?[f];
      } catch (e) {
        res = null;
      }
    }
    return res;
  }
}
