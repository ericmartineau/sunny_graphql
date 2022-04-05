import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sunny_graphql/sunny_graphql_models.dart';

import 'exceptions.dart';
import 'graph_client_serialization.dart';

typedef GraphQLClientGetter = GraphQLClient Function();
typedef ExceptionTranslater = Object Function(GraphOperation operation, dynamic input, OperationException error);

class GraphClientConfig {
  static GraphQLClientGetter? _client;

  static GraphQLClient get client => _client?.call() ?? (throw "No graphQL client was intialized.  Use GraphQuery.init()");

  static GraphSerializer? _serializer;
  static ExceptionTranslater _exceptionTranslater = extractValidationException;

  // = (input, name, isList, isNullable) => input;

  static init(GraphQLClient client, {ExceptionTranslater? exceptionTranslater, GraphSerializer? serializer}) {
    _client = () => client;
    _serializer = serializer ?? _serializer;
    _exceptionTranslater = exceptionTranslater ?? _exceptionTranslater;
  }

  static initGetter(
    GraphQLClientGetter client, {
    ExceptionTranslater? exceptionTranslater,
    GraphSerializer? serializer,
  }) {
    _client = client;
    _serializer = serializer ?? _serializer;
    _exceptionTranslater = exceptionTranslater ?? _exceptionTranslater;
  }

  static Object translateException(GraphOperation operation, dynamic input, OperationException error) {
    return _exceptionTranslater(operation, input, error);
  }

  static T read<T>(dynamic input, {String? typeName, required bool isNullable}) {
    typeName ??= '$T';
    var readValue = _serializer!.read(input, typeName: typeName, isNullable: isNullable);
    assert(readValue is T,
        "Factory didn't convert ${input?.runtimeType} into a ${T} for type: '${typeName}, instead was ${input?.runtimeType}");
    return readValue as T;
  }

  static List<T> readList<T>(dynamic input, {String? typeName, required bool isNullable}) {
    return _serializer!.readList<T>(input, typeName: typeName, isNullable: isNullable);
  }

  static write(dynamic input, {required String typeName, required bool isList}) {
    return _serializer!.write(input, typeName: typeName, isList: isList);
  }

  static D doubleOf<D>(json) {
    if (json == null) return null as D;
    if (json is double) {
      return json as D;
    } else if (json is num) {
      return json.toDouble() as D;
    } else {
      return null as D;
    }
  }

  static T intOf<T>(json) {
    if (json == null) return null as T;
    if (json is int) {
      return json as T;
    } else if (json is num) {
      return json.toInt() as T;
    } else {
      return null as T;
    }
  }

  ///
  /// Retrieves a
  static getDeep(json, [f1, f2, f3]) {
    var res = json;
    if (json == null) return null;

    for (var f in [if (f1 != null) f1, if (f2 != null) f2, if (f3 != null) f3]) {
      try {
        res = res?[f];
      } catch (e) {
        res = null;
      }
    }
    return res;
  }
}
