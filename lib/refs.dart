import 'package:gql/ast.dart';
import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_sdk_core/api_exports.dart';
import 'package:sunny_sdk_core/model_exports.dart';

typedef JsonObject = Map<String, dynamic>;
typedef JsonValue = dynamic;
typedef FieldRefInput = dynamic;

abstract class JoinRecordData {
  dynamic toJson();

  JsonObject toMap();

  JoinRecordData clone();

  void operator []=(String key, value);

  dynamic operator [](key);
}

/// Represents a join between records which also contains properties about the relationship.
/// property node The target entity that's referenced
/// property self The
class JoinRecord<T1 extends Entity, T2 extends Entity,
    D extends JoinRecordData> {
  T1 node;

  T2? _self;

  T2 get self => _self ?? (throw "self has not been initialized");

  set self(T2 self) => this._self = self;

  D details;

  JoinRecord(this.node, this.details, [this._self]) {}

  factory JoinRecord.fromJson(json) {
    final jsonMap = json as Map<String, dynamic>;
    final node = jsonMap.remove("node");
    return JoinRecord<T1, T2, D>(
        GraphClientConfig.read<T1>(node, isNullable: false),
        GraphClientConfig.read<D>(jsonMap, typeName: '$D', isNullable: false));
  }

  /// Flips this record so that the 'self' is in the 'node' position, and vice versa.
  JoinRecord<T2, T1, D> flip() => JoinRecord(self, details, node);

  /// Recasts this record using the [T1] [node] type.
  JoinRecord<TT, T2, D> cast<TT extends Entity>() =>
      JoinRecord(node as TT, details, _self);

  /// Recasts this record using the [T1] [node] and the [T2] [self] types.
  JoinRecord<TT, TT2, D> cast2<TT extends Entity, TT2 extends Entity>() =>
      JoinRecord(node as TT, details, _self as TT2);

  /// Recasts this record using the [T1] [node] and the [T2] [self] types.
  JoinRecord<T1, TT2, D> castSelf<TT2 extends Entity>([TT2? self]) =>
      JoinRecord(node, details, self ?? _self as TT2);

  dynamic toJson() {
    return {
      "node": (node as BaseSunnyEntity).toJson(),
      ...details.toJson(),
    };
  }
}

extension ListOfJoinRecordExt<T1 extends Entity, T2 extends Entity,
    D extends JoinRecordData> on List<JoinRecord<T1, T2, D>>? {
  /// Sets the [JoinRecord.self] property for all items in a list
  set self(T2 self) {
    final me = this;
    if (me == null) return;
    for (var item in me) {
      item.self = self;
    }
  }

  List<JoinRecord<T2, T1, D>> flip() {
    final self = this;
    if (self == null) return [];
    return [
      for (var item in self) item.flip(),
    ];
  }
}

extension JsonValueExt on Object? {
  T get<T extends Object?>(name) {
    if (this == null) {
      return null as T;
    } else {
      return (this as dynamic)[name] as T;
    }
  }
}

enum GraphOperationType {
  disconnect,
  connect,
  create,
  connectOrCreate,
  update;

  String toString() {
    return this.name;
  }
}

abstract class GraphRefInput {
  // FieldRefInput? get relatedJson;

  /// Returns the full outer ref input, including the recordType and the operation
  /// type
  Object? toJson();

  // /// Returns just the inner guts, assuming the outer entity has grouped by recordType
  // /// and operation
  // Object? toInnerJson();
}

mixin SingleRefMixin implements GraphRefInput {
  String? get linkedId;
  GraphInput? get create;
  GraphInput? get update;
  bool get isDisconnect;
  bool get canDisconnect;
  Object? get edgeData;
  String? get recordType;

  GraphOperationType? get operation {
    if (linkedId != null && create != null) {
      return GraphOperationType.connectOrCreate;
    } else if (isDisconnect && canDisconnect) {
      return GraphOperationType.disconnect;
    } else if (linkedId != null) {
      return GraphOperationType.connect;
    } else if (create != null) {
      return GraphOperationType.create;
    } else if (update != null) {
      return GraphOperationType.update;
    } else {
      return null;
    }
  }

  Object? toInnerJson() {
    var op = operation;
    if (op == null) return null;
    switch (op) {
      case GraphOperationType.disconnect:
        return {
          "where": {
            "node": {
              if (linkedId == null) "id_NOT": null else "id": linkedId!,
            }
          }
        };
      case GraphOperationType.connect:
        return {
          "where": {
            "node": {
              "id": linkedId!,
            },
          },
          if (edgeData != null) "edge": edgeData,
        };

      case GraphOperationType.create:
        return {
          "node": create!.toJson(),
          if (edgeData != null) 'edge': edgeData,
        };

      case GraphOperationType.connectOrCreate:
        return {
          "where": {
            "node": {
              "id": linkedId!,
            }
          },
          'onCreate': {
            'node': create!.toJson(),
            if (edgeData != null) 'edge': edgeData,
          }
        };
      case GraphOperationType.update:
        return {
          "where": {
            "node": {
              "id": linkedId!,
            }
          },
          'update': {
            'node': update!.toJson(),
            if (edgeData != null) 'edge': edgeData,
          }
        };
    }
  }

  @override
  Object? toJson() {
    var inner = toInnerJson();
    if (inner == null) {
      return null;
    }
    var json = {operation!.name: inner};
    return (recordType != null)
        ? {
            recordType: json,
          }
        : json;
  }
}

class NullableGraphRef<E extends Entity, C extends GraphInput,
    U extends GraphInput> with SingleRefMixin {
  final String? _linkedId;
  final C? _create;
  final U? _update;
  final String? recordType;
  final bool isDisconnect;
  final String? refLabel;

  Object? get edgeData => null;

  const NullableGraphRef.connect(this._linkedId,
      [this.recordType, this.refLabel])
      : _create = null,
        isDisconnect = false,
        _update = null;

  const NullableGraphRef.connectOrCreate(String linkedId, C create,
      [this.recordType, this.refLabel])
      : _create = create,
        _linkedId = linkedId,
        isDisconnect = false,
        _update = null;

  NullableGraphRef.update(String id, U update, [this.recordType, this.refLabel])
      : _update = update,
        isDisconnect = false,
        _linkedId = id,
        _create = null;

  NullableGraphRef.connection(E entity, [String? _recordType, this.refLabel])
      : _linkedId = entity.id,
        recordType = (_recordType ??
            ((entity is BaseSunnyEntity)
                ? capitalize((entity).mkey!.mtype.artifactId!)
                : null)),
        _update = null,
        isDisconnect = false,
        _create = null;

  NullableGraphRef.create(C entity, [this.recordType, this.refLabel])
      : _create = entity,
        _update = null,
        isDisconnect = false,
        _linkedId = null;

  const NullableGraphRef.disconnect([this.refLabel])
      : _linkedId = null,
        _create = null,
        recordType = null,
        isDisconnect = true,
        _update = null;

  bool get canDisconnect => true;

  String? get linkedId => _linkedId;

  C? get create => _create;

  U? get update => _update;
}

class NullableExtGraphRef<R extends Entity, E extends JoinRecordData,
    C extends GraphInput, U extends GraphInput> with SingleRefMixin {
  final String? _linkedId;
  final E? _props;
  final C? _create;
  final U? _update;
  bool get isConnectOrCreate => _linkedId != null && _create != null;
  final bool isDisconnect;
  final String? _recordType;

  String? get linkedId => _linkedId;
  final String? refLabel;

  const NullableExtGraphRef.connect(this._linkedId, E props,
      [this._recordType, this.refLabel])
      : _create = null,
        _props = props,
        isDisconnect = false,
        _update = null;

  NullableExtGraphRef.connection(JoinRecord<R, Entity, E> entity,
      [this._recordType, this.refLabel])
      : _linkedId = entity.node.mkey?.mxid,
        _props = entity.details,
        _update = null,
        isDisconnect = false,
        _create = null;

  NullableExtGraphRef.create(C entity, E props,
      [this._recordType, this.refLabel])
      : _create = entity,
        _update = null,
        _props = props,
        isDisconnect = false,
        _linkedId = null;

  NullableExtGraphRef.connectOrCreate(String linkedId, C onCreate, E props,
      [this._recordType, this.refLabel])
      : _create = onCreate,
        _update = null,
        _props = props,
        isDisconnect = false,
        _linkedId = linkedId;

  const NullableExtGraphRef.disconnect([this._recordType, this.refLabel])
      : _linkedId = null,
        _create = null,
        _props = null,
        isDisconnect = true,
        _update = null;

  @override
  bool get canDisconnect => true;

  @override
  GraphInput? get create => _create;

  @override
  Object? get edgeData => _props?.toJson() as Object?;

  @override
  String? get recordType => _recordType;

  @override
  GraphInput? get update => _update;
}

class ExtGraphRef<
    R extends Entity,
    E extends JoinRecordData,
    C extends GraphInput,
    U extends GraphInput> extends NullableExtGraphRef<R, E, C, U> {
  ExtGraphRef.connectOrCreate(String linkedId, C create, E props,
      [String? recordType])
      : super.connectOrCreate(linkedId, create, props, recordType);

  ExtGraphRef.connect(String linkedId, E props, [String? recordType])
      : super.connect(linkedId, props, recordType);

  ExtGraphRef.connection(JoinRecord<R, Entity, E> entity, [String? recordType])
      : super.connection(entity, recordType);

  ExtGraphRef.create(C entity, E props, [String? recordType])
      : super.create(entity, props, recordType);
}

class GraphRef<E extends Entity, C extends GraphInput, U extends GraphInput>
    extends NullableGraphRef<E, C, U> {
  GraphRef.connect(String linkedId, [String? recordType])
      : super.connect(linkedId, recordType);

  GraphRef.connectOrCreate(String linkedId, C create, [String? recordType])
      : super.connectOrCreate(linkedId, create, recordType);

  GraphRef.connection(E entity, [String? recordType])
      : super.connection(entity, recordType);

  GraphRef.create(C create, [String? recordType])
      : super.create(create, recordType);

  GraphRef.update(String id, U update, [String? recordType])
      : super.update(id, update, recordType);

  bool get canDisconnect => false;
}

class NullableUnionGraphRef<E extends Entity, C extends GraphInput,
    U extends GraphInput> extends NullableGraphRef<E, C, U> {
  NullableUnionGraphRef.connect(String linkedId, String recordType)
      : super.connect(linkedId, recordType);

  NullableUnionGraphRef.connection(E entity)
      : assert(entity is BaseSunnyEntity),
        super.connect(entity.id,
            capitalize((entity as BaseSunnyEntity).mtype.artifactId!));

  NullableUnionGraphRef.create(C create, String recordType)
      : super.create(create, recordType);

  NullableUnionGraphRef.update(String id, U update, String recordType)
      : super.update(id, update, recordType);

  bool get canDisconnect => false;
}

class UnionGraphRef<E extends Entity, C extends GraphInput,
    U extends GraphInput> extends GraphRef<E, C, U> {
  UnionGraphRef.connect(String linkedId, String recordType)
      : super.connect(linkedId, recordType);

  UnionGraphRef.connection(E entity)
      : assert(entity is BaseSunnyEntity),
        super.connect(entity.id,
            capitalize((entity as BaseSunnyEntity).mtype.artifactId!));

  UnionGraphRef.create(C create, String recordType)
      : super.create(create, recordType);

  UnionGraphRef.update(String id, U update, String recordType)
      : super.update(id, update, recordType);

  bool get canDisconnect => false;
}

class GraphEnum<T> {
  final T value;

  const GraphEnum(this.value);

  T toJson() => value;
}

mixin GraphRefListMixin implements GraphRefInput {
  Iterable<SingleRefMixin> get connect;

  @override
  Object? toJson() {
    var byRecordTypeAndOperation = connect.groupBy((c) => c.recordType).map(
        (recordType, listOfConnect) => MapEntry(
            recordType, listOfConnect.groupBy((value) => value.operation)));
    Map<String, Object?> expandOperations(String? recordType,
        Map<GraphOperationType?, List<SingleRefMixin>> input) {
      var expandedOperations = <String, Object?>{};
      input.forEach((key, value) {
        if (key != null && input.length > 0) {
          expandedOperations[key.name] = [
            for (var ref in value) ref.toInnerJson(),
          ];
        }
      });
      if (expandedOperations.isEmpty) {
        return <String, Object?>{};
      } else {
        return recordType == null
            ? expandedOperations
            : {recordType.replaceAll("CreateInput", ""): expandedOperations};
      }
    }

    return {
      for (var recordEntry in byRecordTypeAndOperation.entries)
        ...expandOperations(recordEntry.key, recordEntry.value),
    };
  }
}

class GraphRefList<E extends Entity, C extends GraphInput, U extends GraphInput,
    G extends NullableGraphRef<E, C, U>> with GraphRefListMixin {
  final Iterable<G> _connect;
  final Iterable<String> _disconnect;
  final bool isReplace;

  const GraphRefList(
      {Iterable<G> connect = const [], Iterable<String> disconnect = const []})
      : _connect = connect,
        isReplace = false,
        _disconnect = disconnect;

  const GraphRefList.list(
      {Iterable<G> connect = const [], Iterable<String> disconnect = const []})
      : _connect = connect,
        isReplace = false,
        _disconnect = disconnect;

  const GraphRefList.replace(
      {Iterable<G> connect = const [], Iterable<String> disconnect = const []})
      : _connect = connect,
        isReplace = true,
        _disconnect = disconnect;

  Iterable<G> get connect => [..._connect];

  // @override
  // Object? toJson() {
  //   var byRecordTypeAndOperation = _connect.groupBy((c) => c.recordType).map(
  //       (recordType, listOfConnect) => MapEntry(
  //           recordType, listOfConnect.groupBy((value) => value.operation)));
  //   Map expandOperations(
  //       String? recordType, Map<GraphOperationType?, List<G>> input) {
  //     var expandedOperations = {};
  //     input.forEach((key, value) {
  //       if (key != null && input.length > 0) {
  //         expandedOperations[key.name] = [
  //           for (var ref in value) ref.toInnerJson(),
  //         ];
  //       }
  //     });
  //     if (expandedOperations.isEmpty) {
  //       return {};
  //     } else {
  //       return recordType == null
  //           ? expandedOperations
  //           : {recordType.replaceAll("CreateInput", ""): expandedOperations};
  //     }
  //   }
  //
  //   return {
  //     for (var recordEntry in byRecordTypeAndOperation.entries)
  //       ...expandOperations(recordEntry.key, recordEntry.value),
  //   };

  // // final _createList = _connect.where((c) => c._create != null);
  // // final _createByType = <String?, List<C>>{};
  // // final _connectByType = <String?, List<String>>{};
  // for (var item in _createList) {
  //   _createByType.putIfAbsent(item.recordType, () => []).add(item.create!);
  // }
  // final _connectList = _connect.where((c) => c._linkedId != null);
  // for (var connect in _connectList) {
  //   _connectByType
  //       .putIfAbsent(connect.recordType, () => [])
  //       .add(connect._linkedId!);
  // }
  //
  // if (_connectList.isNotEmpty ||
  //     _disconnect.isNotEmpty ||
  //     _createList.isNotEmpty) {
  //   var result = {};
  //   if (isReplace) {
  //     result["disconnect"] = [
  //       {
  //         "where": {
  //           "node": {
  //             "id_NOT_IN": _connectList.map((e) => e._linkedId!).toList(),
  //           }
  //         }
  //       }
  //     ];
  //   } else if (_disconnect.isNotEmpty) {
  //     result['disconnect'] = {
  //       "where": {
  //         "node": {
  //           "id_IN": _disconnect.toList(),
  //         }
  //       }
  //     };
  //   }
  //
  //   if (_connectByType.isNotEmpty) {
  //     _connectByType.forEach((key, value) {
  //       var connect = {
  //         "where": {
  //           "node": {
  //             "id_IN": value,
  //           }
  //         }
  //       };
  //       if (key == null) {
  //         result["connect"] = connect;
  //       } else {
  //         result[key] = {
  //           "connect": connect,
  //         };
  //       }
  //     });
  //   }
  //   if (_createList.isNotEmpty) {
  //     _createByType.forEach((key, value) {
  //       var create = [
  //         for (var node in value)
  //           {
  //             "node": node.toJson(),
  //           },
  //       ];
  //
  //       if (key == null) {
  //         result["create"] = create;
  //       } else {
  //         result.putIfAbsent(
  //             key.replaceAll("CreateInput", ""), () => {})["create"] = create;
  //       }
  //     });
  //   }
  //   return result;
  // } else {
  //   return null;
  // }
  // }

  GraphRefList<E, C, U, G> withConnection({E? record, String? linkedId}) {
    var id = record?.id ?? linkedId;
    if (id == null) {
      return this;
    }
    return GraphRefList(connect: [
      ..._connect,
      GraphRef<E, C, U>.connect(id) as G,
    ], disconnect: _disconnect);
  }

  GraphRefList<E, C, U, G> withoutConnection({E? record, String? linkedId}) {
    var id = record?.id ?? linkedId;
    if (id == null) {
      return this;
    }
    return GraphRefList(connect: [
      for (final c in _connect)
        if (c.linkedId != id) c,
    ], disconnect: _disconnect);
  }
}

class ExtGraphRefList<
    R extends Entity,
    E extends JoinRecordData,
    C extends GraphInput,
    U extends GraphInput,
    G extends ExtGraphRef<R, E, C, U>> with GraphRefListMixin {
  final List<G> _connect;
  final List<String> _disconnect;
  final bool _isAll;
  final bool isReplace;

  const ExtGraphRefList(
      {List<G> connect = const [],
      List<String> disconnect = const [],
      required this.isReplace})
      : _connect = connect,
        _isAll = true,
        _disconnect = disconnect;

  const ExtGraphRefList.list(
      {List<G> connect = const [], List<String> disconnect = const []})
      : _connect = connect,
        _isAll = true,
        isReplace = false,
        _disconnect = disconnect;

  const ExtGraphRefList.replace(
      {List<G> connect = const [], List<String> disconnect = const []})
      : _connect = connect,
        _isAll = true,
        isReplace = true,
        _disconnect = disconnect;

  ExtGraphRefList.single({G? connect, String? disconnect})
      : _connect = [if (connect != null) connect],
        _disconnect = [if (disconnect != null) disconnect],
        isReplace = false,
        _isAll = false;

  Iterable<String> get connectIds =>
      _connect.map((e) => e._linkedId).whereType();

  Iterable<String> get disconnectIds => _disconnect;

  @override
  Iterable<SingleRefMixin> get connect => _connect;

  // @override
  // FieldRefInput? get relatedJson {
  //   var _byType = <String?, Map<String, List<Object?>>>{};
  //   for (var ref in _connect) {
  //     var updates = _byType.putIfAbsent(ref._recordType, () => {});
  //     if (ref._create != null) {
  //       // final list = data.putIfAbsent('create', () => []) as List;
  //       updates.putIfAbsent('create', () => []).add({
  //         "node": ref._create!.toJson(),
  //         "edge": (ref._props!.toJson() as Object?)?.withoutKey('node'),
  //       });
  //     } else if (ref._linkedId != null) {
  //       updates.putIfAbsent('connect', () => []).add({
  //         "where": {
  //           "node": {"id": ref._linkedId!},
  //         },
  //         "edge": (ref._props!.toJson() as Object?)?.withoutKey('node'),
  //       });
  //     }
  //   }
  //   // final _createList = _connect.where((c) => c._create != null);
  //   // final _createByType = <String?, List<C>>{};
  //   // final _connectByType = <String?, List<String>>{};
  //   // for (var item in _createList) {
  //   //   _createByType.putIfAbsent(item._recordType, () => []).add(item._create!);
  //   // }
  //   // final _connectList = _connect.where((c) => c._linkedId != null);
  //   // for (var connect in _connectList) {
  //   //   _connectByType
  //   //       .putIfAbsent(connect._recordType, () => [])
  //   //       .add(connect._linkedId!);
  //   // }
  //
  //   // if (_connect.isNotEmpty || _disconnect.isNotEmpty) {
  //   //   for (var ref in _connect) {
  //   //     if (ref._create != null) {
  //   //       final list = data.putIfAbsent('create', () => []) as List;
  //   //       list.add({
  //   //         "node": ref._create!.toJson(),
  //   //         "edge": (ref._props!.toJson() as Object?)?.withoutKey('node'),
  //   //       });
  //   //     } else if (ref._linkedId != null) {
  //   //       final list = data.putIfAbsent('connect', () => []) as List;
  //   //       list.add({
  //   //         "where": {
  //   //           "node": {"id": ref._linkedId!},
  //   //         },
  //   //         "edge": (ref._props!.toJson() as Object?)?.withoutKey('node'),
  //   //       });
  //   //     }
  //   //   }
  //   // }
  //
  //   var types = _byType.keys;
  //   if (types.length == 1 && types.first == null) {
  //     return {
  //       ..._byType.values.first,
  //       if (isReplace)
  //         "disconnect": {
  //           "where": {
  //             "node": {
  //               "id_NOT_IN": _connect
  //                   .map((e) => e._linkedId)
  //                   .whereType<String>()
  //                   .toList(),
  //             }
  //           }
  //         },
  //     };
  //   } else {
  //     if (isReplace) {
  //       _byType.values.forEach((element) {
  //         element['disconnect'] = [
  //           {
  //             "where": {
  //               "node": {
  //                 "id_NOT_IN": _connect
  //                     .map((e) => e._linkedId)
  //                     .whereType<String>()
  //                     .toList(),
  //               }
  //             }
  //           }
  //         ];
  //       });
  //     }
  //     return _byType;
  //   }
  // }

  // @override
  // Object? toJson() => relatedJson;
}

extension _EntityIdExt on Entity {
  String get id => mkey!.mxid;
}

typedef RelatedBuilder = void Function(JsonObject data);

Map<String, dynamic>? relatedToJson(List<RelatedBuilder> rel) {
  JsonObject data = {};
  for (var r in rel) {
    r(data);
  }
  return data.isEmpty ? null : data;
}

// typedef GraphInputMap = Map<String, Map<String, dynamic>>;

/// This is more complicated because previously we were needing to pull the field json out into a separate root
RelatedBuilder relatedFieldJson(String fieldName, dynamic json) {
  return (JsonObject map) {
    if (json == null ||
        (json is Map && json.isEmpty) ||
        (json is Iterable && json.isEmpty)) {
      return;
    }
    map[fieldName] = json;
  };
}
