import 'package:gql/ast.dart';

mixin FragmentManager {
  final Map<String, Set<FragmentDefinitionNode>> _resolved = {};
  final Set<String> _inflight = {};
  final Map<String, FragmentDefinitionNode> _fragmentsByName = {};

  Set<FragmentDefinitionNode> _getFragments(SelectionSetNode? selectionSet, [Map<String, FragmentDefinitionNode?>? cached]) {
    final processed = cached ?? {};
    selectionSet?.selections.forEach((element) {
      if (element is FieldNode) {
        _getFragments(element.selectionSet, processed);
      } else if (element is FragmentSpreadNode) {
        if (!processed.containsKey(element.name.value)) {
          processed[element.name.value] = null;
          processed.addAll(_getDependentFragments(element.name.value).keyed);
        } else if (processed[element.name.value] == null) {
          // Attempting to nest!
          print("ALERT - NESTING FRAGMENTS IS BAD");
        }
      } else if (element is InlineFragmentNode) {
        _getFragments(element.selectionSet, processed);
      }
    });
    return processed.values.whereType<FragmentDefinitionNode>().toSet();
  }

  Set<FragmentDefinitionNode> _getDependentFragments(
    String fragmentName,
  ) {
    final fname = _fragmentName(fragmentName);
    final key = 'Fragment:$fname';

    return _resolved.putIfAbsent(key, () {
      if (_inflight.contains(key)) {
        // Big problemo!
        throw "Nested fragments are not allowed: $_inflight";
      }
      _inflight.add(key);
      var frag = getFragment(fname);
      final processed = <String, FragmentDefinitionNode>{};
      processed[fname] = frag;
      final deps = getFragmentsForSelection(frag.selectionSet);
      processed.addAll(deps.keyed);
      _inflight.remove(key);
      return processed.values.toSet();
    });
  }

  Set<FragmentDefinitionNode> getFragmentsForOperation(
    OperationDefinitionNode operation,
  ) {
    return _resolved.putIfAbsent('Operation:${operation.name!.value}', () {
      return _getFragments(operation.selectionSet);
    });
  }

  String _fragmentName(String of) {
    return !of.endsWith("Fragment") ? '${of}Fragment' : of;
  }

  FragmentDefinitionNode getFragment(String name) {
    var fragment = _fragmentsByName[_fragmentName(name)];
    if (fragment == null) {
      throw StateError("No fragment for $name");
    } else {
      return fragment;
    }
  }

  Set<FragmentDefinitionNode> getFragmentsForSelection(SelectionSetNode selectionSet) {
    return _getFragments(selectionSet);
  }

  void initializeFragments({
    required List<FragmentDefinitionNode> fragments,
  }) {
    this._fragmentsByName.addAll(fragments.toSet().keyed);
  }
}

extension SetFragDefsExt on Set<FragmentDefinitionNode> {
  Map<String, FragmentDefinitionNode> get keyed => {
        for (var f in this) f.name.value: f,
      };
}
