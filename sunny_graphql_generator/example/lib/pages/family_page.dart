import 'package:example/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../graphql_stuff.dart';
import '../ref_tile.dart';

class FamilyPage extends StatefulWidget {
  final FamilyTribe family;

  const FamilyPage({Key? key, required this.family}) : super(key: key);
  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  void initState() {
    super.initState();
    loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final family = widget.family;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(family.tribe.displayName),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.refresh),
          onPressed: loadAll,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            RefAvatar(family.tribe),
            const SizedBox(height: 10),
            Center(
              child: Text(
                family.tribe.displayName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 30),
            if (family.parents.isNotEmpty) ...[
              Text("Parents", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              for (var parent in family.parents) RefTile(ref: parent),
            ],
            if (family.children.isNotEmpty) ...[
              Text("Children", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              for (var child in family.children) RefTile(ref: child),
            ],
          ],
        ),
      ),
    );
  }

  Future loadAll() async {
    setState(() {});
  }
}
