import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

extension ElementReadAnnotation on Element {
  Annotated<AnnotationType>? readAnnotation<AnnotationType>() {
    final element = this;
    return Annotated(element, _getAnnotation<AnnotationType>(element));
  }
}

/// Returns the annotation of type [AnnotationType] of the given [element],
/// or [null] if it doesn't have any.
/// }
DartObject? _getAnnotation<AnnotationType>(Element element) {
  final annotations =
      TypeChecker.fromRuntime(AnnotationType).annotationsOf(element);
  if (annotations.isEmpty) {
    return null;
  }
  if (annotations.length > 1) {
    throw Exception(
        "You tried to add multiple @$AnnotationType() annotations to the "
        "same element (${element.name}), but that's not possible.");
  }
  return annotations.single;
}

class Annotated<T> {
  final Element element;
  final DartObject? annotationObj;
  final ConstantReader? reader;

  Annotated(this.element, [this.annotationObj])
      : reader = annotationObj == null ? null : ConstantReader(annotationObj);

  T get<T>(String field) {
    return reader?.read(field).literalValue as T;
  }

  bool get hasAnnotation => reader != null;
}
