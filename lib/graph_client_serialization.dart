typedef GraphQueryWriter = dynamic Function(dynamic input, String name, bool isList, bool isNullable);
typedef GraphQueryReader = dynamic Function(dynamic input, String name, bool isList, bool isNullable);

typedef EntityReader = dynamic Function(dynamic input);
typedef EntityWriter = dynamic Function(dynamic input);
typedef EntityReaderFactory = EntityReader? Function(String name);
typedef EntityWriterFactory = EntityWriter? Function(String name);

abstract class GraphSerializer {
  dynamic write(dynamic input, {required String typeName, required bool isList});
  T read<T>(dynamic input, {required String typeName, required bool isNullable});
  List<T> readList<T>(dynamic input, {required String typeName, required bool isNullable});
}

class FactoryGraphSerializer implements GraphSerializer {
  final List<EntityReaderFactory> _readerFactories;
  final List<EntityWriterFactory> _writerFactories;

  FactoryGraphSerializer()
      : _readerFactories = [],
        _writerFactories = [];

  void addWriter(EntityWriterFactory factory) {
    _writerFactories.add(factory);
  }

  void addReader(EntityReaderFactory factory) {
    _readerFactories.add(factory);
  }

  @override
  dynamic write(dynamic input, {required String typeName, required bool isList}) {
    final factory = _writerFactories.map((e) => e(typeName)).firstWhere(
          (element) => element != null,
          orElse: () => (dynamic input) => input,
        )!;
    if (isList) {
      return [
        ...?(input as List?)?.map((item) => factory(item)),
      ];
    } else {
      return factory(input);
    }
  }

  @override
  T read<T>(dynamic input, {required String typeName, required bool isNullable}) {
    if (isNullable && input == null) {
      return null as T;
    }
    final factory = _readerFactories.map((e) => e(typeName)).firstWhere(
          (element) => element != null,
          orElse: () => (dynamic input) => input,
        );

    if (input == null) {
      throw "Null value not allowed for type ${typeName}";
    }
    return factory!(input) as T;
  }

  @override
  List<T> readList<T>(dynamic input, {required String typeName, required bool isNullable}) {
    final factory = _readerFactories.map((e) => e(typeName)).firstWhere(
          (element) => element != null,
          orElse: () => (dynamic input) => input,
        );

    return <T>[
      ...?(input as Iterable?)?.map((e) => factory!(e) as T),
    ];
  }
}
