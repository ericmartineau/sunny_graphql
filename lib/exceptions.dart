import 'package:dartxx/json_path.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_sdk_core/api/api_exceptions.dart';

final FIELD_ERROR = RegExp(r'Field "(.*?)" of required type "(.*?)" was not provided');

Object extractValidationException(GraphOperation operation, dynamic input, OperationException exception) {
  List<GraphQLError> graphQLErrors = [];

  final linkException = exception.linkException;

  graphQLErrors.addAll(exception.graphqlErrors);
  if (linkException is ServerException) {
    if (linkException.originalException?.runtimeType == 'SocketException') {
      return ApiException.socket(linkException.originalException as Object, StackTrace.current);
    }

    var parsedResponse = linkException.parsedResponse;
    if (parsedResponse?.errors?.isNotEmpty == true) {
      graphQLErrors.addAll(parsedResponse!.errors!);
    }
  }

  var validationErrors =
      graphQLErrors.where((element) => element.isValidationError).expand((element) => element.validationErrors).toList();

  if (validationErrors.isNotEmpty) {
    return operation.isMutate
        ? BadRequestException(
            'Validation errors:\n  - ${validationErrors.map((e) => e.toString()).join("\n  -")}', validationErrors)
        : ApiException.response(500, "Invalid data from the server",
            errors: ApiErrorPayload(
                errorType: "Invalid data assertion",
                errors: validationErrors.map((e) {
                  return ApiErrorItem(message: "${e.path.toKey()}: ${e}", body: e.toMap());
                }).toList()));
  } else {
    return ApiException.response(
        500,
        [
          for (var error in exception.graphqlErrors) error.message,
          if (exception.linkException != null) ...[
            exception.linkException!.toString(),
          ],
        ].join('\n'));
  }
}

extension _GraphQLErrorsExt on Iterable<GraphQLError> {}

extension _GraphQLErrorExt on GraphQLError {
  bool get isValidationError {
    return exception["code"] == "ERR_GRAPHQL_CONSTRAINT_VALIDATION" || code == "BAD_USER_INPUT";
  }

  List<ValidationError> get validationErrors {
    if (!isValidationError) return const <ValidationError>[];
    if (code == "BAD_USER_INPUT") {
      return [
        for (var match in FIELD_ERROR.allMatches(message))
          ValidationError(
              path: JsonPath.parsed(match.group(1)!),
              value: null,
              code: ValidationError.requiredCode,
              keyword: 'required',
              arguments: [match.group(1), match.group(2)],
              debugMessage: match.group(0),
              message: 'Missing required field'),
      ];
    } else if (exception["code"] == "ERR_GRAPHQL_CONSTRAINT_VALIDATION") {
      return [
        for (var constraint in fieldConstraintViolations)
          ValidationError(
              path: JsonPath.parsed(constraint.fieldName),
              keyword: 'validation.${constraint.arg ?? 'unknown'}',
              code: constraint.arg ?? 'error',
              arguments: [
                if (constraint.arg != null) constraint.arg,
              ],
              message: constraint.message),
      ];
    } else {
      throw StateError("Unhandled validation error type");
    }
  }

  String? get code => extensions == null ? null : extensions!["code"] as String?;

  List<GraphConstraintViolation> get fieldConstraintViolations {
    final fieldName = exception["fieldName"] as String;
    final context = exception["context"];
    if (context is Iterable) {
      return context.map((c) {
        return GraphConstraintViolation(fieldName, c["arg"] as String?, c["value"] as Object?);
      }).toList();
    } else {
      return [GraphConstraintViolation(fieldName)];
    }
  }

  Map<String, dynamic> get exception {
    if (extensions == null) {
      return const {};
    }
    assert(extensions!["exception"] is Map, "Map should be");
    return (extensions!["exception"] as Map).cast();
  }
}

class GraphConstraintViolation {
  final String fieldName;
  final String? arg;
  final Object? value;
  final String message;

  GraphConstraintViolation(this.fieldName, [this.arg, this.value]) : message = _buildConstraintMessage(arg, value);
}

String _buildConstraintMessage(arg, value) {
  switch (arg) {
    case 'minLength':
      return 'must have length of at least $value';
    default:
      return 'failed validation: $arg=$value';
  }
}
