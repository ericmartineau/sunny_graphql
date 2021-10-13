import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:sunny_sdk_core/mverse.dart';

typedef JsonObject = Map<String, dynamic>;
typedef JsonValue = dynamic;
typedef FieldRefInput = dynamic;

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
}

class NullableGraphRef<E extends Entity, C extends GraphInput, U extends GraphInput> implements GraphRefInput {
  final String? _linkedId;
  final C? _create;
  final U? _update;
  final String? _recordType;
  final bool isDisconnect;

  const NullableGraphRef.connect(this._linkedId, [this._recordType])
      : _create = null,
        isDisconnect = false,
        _update = null;

  NullableGraphRef.update(String id, U update, [this._recordType])
      : _update = update,
        isDisconnect = false,
        _linkedId = id,
        _create = null;

  NullableGraphRef.connection(E entity, [this._recordType])
      : _linkedId = entity.id,
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
      json = isDisconnect ? {"disconnect": {}} : null;
    } else {
      json = {
        "connect": {
          "where": {
            "node": {
              "id": _linkedId,
            }
          }
        },
        if (_recordType == null)
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

  C? get create => _create;
  U? get update => _update;
}

class NullableExtGraphRef<R extends Entity, E extends JoinTypeMixin<R>, C extends GraphInput, U extends GraphInput>
    implements GraphRefInput {
  final String? _linkedId;
  final E? _props;
  final C? _create;
  final U? _update;
  final bool isDisconnect;

  const NullableExtGraphRef.connect(this._linkedId, E props)
      : _create = null,
        _props = props,
        isDisconnect = false,
        _update = null;

  NullableExtGraphRef.connection(E entity)
      : _linkedId = entity.node?.mkey?.mxid,
        _props = entity,
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
          "edge": _props!.toJson(),
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
}

class ExtGraphRef<R extends Entity, E extends JoinTypeMixin<R>, C extends GraphInput, U extends GraphInput>
    extends NullableExtGraphRef<R, E, C, U> {
  ExtGraphRef.connect(String linkedId, E props) : super.connect(linkedId, props);

  ExtGraphRef.connection(E entity) : super.connection(entity);

  ExtGraphRef.create(C entity, E props) : super.create(entity, props);
}

class GraphRef<E extends Entity, C extends GraphInput, U extends GraphInput> extends NullableGraphRef<E, C, U> {
  GraphRef.connect(String linkedId, [String? recordType]) : super.connect(linkedId, recordType);

  GraphRef.connection(E entity) : super.connection(entity);

  GraphRef.create(C create) : super.create(create);
  GraphRef.update(String id, U update) : super.update(id, update);
}

class GraphEnum<T> {
  final T value;
  const GraphEnum(this.value);
  T toJson() => value;
}

class GraphRefList<E extends Entity, C extends GraphInput, U extends GraphInput> implements GraphRefInput {
  final List<GraphRef<E, C, U>> _connect;
  final List<String> _disconnect;

  const GraphRefList({List<GraphRef<E, C, U>> connect = const [], List<String> disconnect = const []})
      : _connect = connect,
        _disconnect = disconnect;

  @override
  FieldRefInput? get relatedJson {
    final _createList = _connect.map((c) => c._create).whereType<C>().toList();
    final _connectList = _connect.map((c) => c._linkedId).whereType<String>().toList();

    if (_connectList.isNotEmpty || _disconnect.isNotEmpty || _createList.isNotEmpty) {
      return {
        if (_connectList.isNotEmpty)
          "connect": {
            "where": {
              "node": {
                "id_IN": _connectList,
              }
            }
          },
        if (_createList.isNotEmpty)
          "create": {
            "node": _createList.first.toJson(),
          }
      };
    } else {
      return null;
    }
  }
}

class ExtGraphRefList<R extends Entity, E extends JoinTypeMixin<R>, C extends GraphInput, U extends GraphInput>
    implements GraphRefInput {
  final List<ExtGraphRef<R, E, C, U>> _connect;
  final List<String> _disconnect;
  final bool _isAll;

  const ExtGraphRefList.all({List<ExtGraphRef<R, E, C, U>> connect = const [], List<String> disconnect = const []})
      : _connect = connect,
        _isAll = true,
        _disconnect = disconnect;

  ExtGraphRefList.single({ExtGraphRef<R, E, C, U>? connect, String? disconnect})
      : _connect = [if (connect != null) connect],
        _disconnect = [if (disconnect != null) disconnect],
        _isAll = false;

  @override
  FieldRefInput? get relatedJson {
    if (_connect.isNotEmpty || _disconnect.isNotEmpty) {
      return [
        for (var ref in _connect)
          if (ref._create != null)
            {
              "create": {
                "node": ref._create!.toJson(),
                "edge": ref._props!.toJson(),
              }
            }
          else if (ref._linkedId != null)
            {
              "connect": {
                "where": {
                  "node": {"id": ref._linkedId!},
                },
                "edge": ref._props!.toJson(),
              }
            }
      ];
    } else {
      return null;
    }
  }
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
    if (json == null || (json is Map && json.isEmpty) || (json is Iterable && json.isEmpty)) {
      return;
    }
    map[fieldName] = json;
  };
}
