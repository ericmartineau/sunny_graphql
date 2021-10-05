import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

String _repeat(String str, int amount) {
  var str = '';
  for (var i = 0; i < amount; i++) {
    str += str;
  }
  return str;
}

class CodeBuilder {
  final DartEmitter emitter;
  final DartFormatter formatter;
  final String _indent;
  final int indent;
  String _lines = '';

  static Code build(
    void builder(CodeBuilder builder), {
    DartEmitter? emitter,
    DartFormatter? formatter,
    int indent = 0,
  }) {
    var b = CodeBuilder(emitter: emitter, formatter: formatter, indent: indent);
    builder(b);
    return Code(b.toString());
  }

  CodeBuilder({DartEmitter? emitter, DartFormatter? formatter, this.indent = 0})
      : emitter = emitter ?? DartEmitter(),
        _indent = _repeat('  ', indent),
        formatter = formatter ?? DartFormatter(pageWidth: 130);

  CodeBuilder operator +(any) => this.write(any);

  CodeBuilder write(final any) {
    if (any is String) {
      _lines += '${_indent}${any}';
      _lines += '\n';
    } else if (any is Iterable) {
      any.forEach((element) => write(element));
    } else if (any is CodeBuilder) {
      write(any.toString());
    } else if (any is Spec) {
      var code = any.accept(emitter).toString();
      write(formatter.format(code));
    }
    return this;
  }

  void block(String block, void build(CodeBuilder builder)) {
    this.write('${block} {');
    this.write(CodeBuilder.build(
      build,
      indent: indent + 1,
      emitter: emitter,
      formatter: formatter,
    ));
    this.write('}');
  }

  @override
  String toString() {
    return _lines;
  }
}
