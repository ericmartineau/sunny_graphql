import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_sdk_core/api_exports.dart';
import 'package:sunny_sdk_core/mverse.dart';

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
class JoinRecord<T1 extends Entity, T2 extends Entity, D extends JoinRecordData> {
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

  dynamic toJson() {
    return {
      "node": (node as BaseSunnyEntity).toJson(),
      ...details.toJson(),
    };
  }
}

extension ListOfJoinRecordExt<T1 extends Entity, T2 extends Entity, D extends JoinRecordData> on List<
    JoinRecord<T1, T2, D>>? {
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

abstract class GraphRefInput {
  FieldRefInput? get relatedJson;

  Object? toJson();
}

class NullableGraphRef<E extends Entity, C extends GraphInput, U extends GraphInput>
    implements GraphRefInput {
  final String? _linkedId;
  final C? _create;
  final U? _update;
  final String? _recordType;
  final bool isDisconnect;

  bool get canDisconnect => true;

  const NullableGraphRef.connect(this._linkedId, [this._recordType])
      : _create = null,
        isDisconnect = false,
        _update = null;

  NullableGraphRef.update(String id, U update, [this._recordType])
      : _update = update,
        isDisconnect = false,
        _linkedId = id,
        _create = null;

  NullableGraphRef.connection(E entity, [String? _recordType])
      : _linkedId = entity.id,
        _recordType =
        (_recordType ?? ((entity is BaseSunnyEntity) ? capitalize(
            (entity as BaseSunnyEntity).mtype.artifactId!) : null)),
        _update = null,
        isDisconnect = false,
        _create = null;

  NullableGraphRef.create(C entity, [this._recordType])
      : _create = entity,
        _update = null,
        isDisconnect = false,
        _linkedId = null;

  const NullableGraphRef.disconnect()
      : _linkedId = null,
        _create = null,
        _recordType = null,
        isDisconnect = true,
        _update = null;

  @override
  FieldRefInput? get relatedJson {
    var json;
    if (_create != null) {
      json = {
        "create": {
          "node": _create!.toJson(),
        }
      };
    } else if (_linkedId == null) {
      json = (canDisconnect && isDisconnect) ? {"disconnect": {}} : null;
    } else {
      json = {
        "connect": {
          "where": {
            "node": {
              "id": _linkedId,
            }
          }
        },
        // if (_recordType == null)
        if (canDisconnect)
          "disconnect": {
            "where": {
              "node": {
                "id_NOT": _linkedId,
              }
            }
          }
      };
    }

    return (_recordType != null && json != null)
        ? {
      _recordType: json,
    }
        : json;
  }

  Object? toJson() => relatedJson;

  C? get create => _create;

  U? get update => _update;
}

class NullableExtGraphRef<R extends Entity, E extends JoinRecordData, C extends GraphInput, U extends GraphInput>
    implements GraphRefInput {
  final String? _linkedId;
  final E? _props;
  final C? _create;
  final U? _update;
  final bool isDisconnect;

  String get linkedId => linkedId;

  const NullableExtGraphRef.connect(this._linkedId, E props)
      : _create = null,
        _props = props,
        isDisconnect = false,
        _update = null;

  NullableExtGraphRef.connection(JoinRecord<R, Entity, E> entity)
      : _linkedId = entity.node.mkey?.mxid,
        _props = entity.details,
        _update = null,
        isDisconnect = false,
        _create = null;

  NullableExtGraphRef.create(C entity, E props)
      : _create = entity,
        _update = null,
        _props = props,
        isDisconnect = false,
        _linkedId = null;

  const NullableExtGraphRef.disconnect()
      : _linkedId = null,
        _create = null,
        _props = null,
        isDisconnect = true,
        _update = null;

  @override
  FieldRefInput? get relatedJson {
    if (_create != null) {
      return {"node": _create!.toJson()};
    } else if (_linkedId == null) {
      return isDisconnect ? {"disconnect": {}} : null;
    } else {
      return {
        "connect": {
          "where": {
            "node": {
              "id": _linkedId,
            }
          },
          "edge": (_props!.toJson() as Object?)?.withoutKey('node'),
        },
        "disconnect": {
          "where": {
            "node": {
              "id_NOT": _linkedId,
            }
          }
        }
      };
    }
  }

  @override
  Object? toJson() => relatedJson;
}

class ExtGraphRef<R extends Entity, E extends JoinRecordData, C extends GraphInput, U extends GraphInput>
    extends NullableExtGraphRef<R, E, C, U> {
  ExtGraphRef.connect(String linkedId, E props)
      : super.connect(linkedId, props);

  ExtGraphRef.connection(JoinRecord<R, Entity, E> entity)
      : super.connection(entity);

  ExtGraphRef.create(C entity, E props) : super.create(entity, props);
}

class GraphRef<E extends Entity, C extends GraphInput, U extends GraphInput>
    extends NullableGraphRef<E, C, U> {
  GraphRef.connect(String linkedId, [String? recordType])
      : super.connect(linkedId, recordType);

  GraphRef.connection(E entity, [String? recordType])
      : super.connection(entity, recordType);

  GraphRef.create(C create, [String? recordType])
      : super.create(create, recordType);

  GraphRef.update(String id, U update, [String? recordType])
      : super.update(id, update, recordType);

  bool get canDisconnect => false;

  @override
  Object? toJson() => relatedJson;
}

class NullableUnionGraphRef<E extends Entity, C extends GraphInput, U extends GraphInput>
    extends NullableGraphRef<E, C, U> {
  NullableUnionGraphRef.connect(String linkedId, String recordType)
      : super.connect(linkedId, recordType);

  NullableUnionGraphRef.connection(E entity)
      : assert(entity is BaseSunnyEntity),
        super.connect(
          entity.id, capitalize((entity as BaseSunnyEntity).mtype.artifactId!));

  NullableUnionGraphRef.create(C create, String recordType)
      : super.create(create, recordType);

  NullableUnionGraphRef.update(String id, U update, String recordType)
      : super.update(id, update, recordType);

  bool get canDisconnect => false;

  @override
  Object? toJson() => relatedJson;
}

class UnionGraphRef<E extends Entity, C extends GraphInput, U extends GraphInput>
    extends GraphRef<E, C, U> {
  UnionGraphRef.connect(String linkedId, String recordType)
      : super.connect(linkedId, recordType);

  UnionGraphRef.connection(E entity)
      : assert(entity is BaseSunnyEntity),
        super.connect(
          entity.id, capitalize((entity as BaseSunnyEntity).mtype.artifactId!));

  UnionGraphRef.create(C create, String recordType)
      : super.create(create, recordType);

  UnionGraphRef.update(String id, U update, String recordType)
      : super.update(id, update, recordType);

  bool get canDisconnect => false;

  @override
  Object? toJson() => relatedJson;
}

class GraphEnum<T> {
  final T value;

  const GraphEnum(this.value);

  T toJson() => value;
}

class GraphRefList<E extends Entity, C extends GraphInput, U extends GraphInput, G extends NullableGraphRef<
    E,
    C,
    U>>
    implements GraphRefInput {
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

  @override
  FieldRefInput? get relatedJson {
    final _createList = _connect.where((c) => c._create != null);
    final _createByType = <String?, List<C>>{};
    final _connectByType = <String?, List<String>>{};
    for (var item in _createList) {
      _createByType.putIfAbsent(item._recordType, () => []).add(item.create!);
    }
    final _connectList = _connect.where((c) => c._linkedId != null);
    for (var connect in _connectList) {
      _connectByType.putIfAbsent(connect._recordType, () => []).add(
          connect._linkedId!);
    }

    if (_connectList.isNotEmpty || _disconnect.isNotEmpty ||
        _createList.isNotEmpty) {
      var result = {};
      if (isReplace) {
        result["disconnect"] = {
          "where": {
            "node": {
              "id_NOT_IN": _connectList.map((e) => e._linkedId!).toList(),
            }
          }
        };
      }

      if (_connectByType.isNotEmpty) {
        _connectByType.forEach((key, value) {
          var connect = {
            "where": {
              "node": {
                "id_IN": value,
              }
            }
          };
          if (key == null) {
            result["connect"] = connect;
          } else {
            result[key] = {
              "connect": connect,
            };
          }
        });
      }
      if (_createList.isNotEmpty) {
        _createByType.forEach((key, value) {
          var create = [
            for (var node in value)
              {
                "node": node.toJson(),
              },
          ];

          if (key == null) {
            result["create"] = create;
          } else {
            result.putIfAbsent(
                key.replaceAll("CreateInput", ""), () => {})["create"] = create;
          }
        });
      }
      return result;
    } else {
      return null;
    }
  }

  @override
  Object? toJson() => relatedJson;
}

class ExtGraphRefList<R extends Entity, E extends JoinRecordData, C extends GraphInput, U extends GraphInput,
G extends ExtGraphRef<R, E, C, U>>
    implements GraphRefInput {
  final List<G> _connect;
  final List<String> _disconnect;
  final bool _isAll;
  final bool isReplace;

  const ExtGraphRefList(
      {List<G> connect = const [], List<String> disconnect = const [
      ], required this.isReplace})
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
  FieldRefInput? get relatedJson {
    var data = <String, dynamic>{};
    if (_connect.isNotEmpty || _disconnect.isNotEmpty) {
      for (var ref in _connect) {
        if (ref._create != null) {
          final list = data.putIfAbsent('create', () => []) as List;
          list.add({
            "node": ref._create!.toJson(),
            "edge": (ref._props!.toJson() as Object?)?.withoutKey('node'),
          });
        } else if (ref._linkedId != null) {
          final list = data.putIfAbsent('connect', () => []) as List;
          list.add({
            "where": {
              "node": {"id": ref._linkedId!},
            },
            "edge": (ref._props!.toJson() as Object?)?.withoutKey('node'),
          });
        }
      }
    }
    if (isReplace) {
      data["disconnect"] = {
        "where": {
          "node": {
            "id_NOT_IN": _connect.map((e) => e._linkedId)
                .whereType<String>()
                .toList(),
          }
        }
      };
    }
    return data.isEmpty ? null : data;
  }

  @override
  Object? toJson() => relatedJson;
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
    if (json == null || (json is Map && json.isEmpty) ||
        (json is Iterable && json.isEmpty)) {
      return;
    }
    map[fieldName] = json;
  };
}
