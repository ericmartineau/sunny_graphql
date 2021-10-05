import 'package:example/pages/family_page.dart';
import 'package:example/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../graphql_stuff.dart';
import '../ref_tile.dart';

class FamiliesPage extends StatefulWidget {
  @override
  _FamiliesPageState createState() => _FamiliesPageState();
}

class _FamiliesPageState extends State<FamiliesPage> {
  List<FamilyTribe>? families;

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text("Families"),
          trailing: CupertinoButton(
            onPressed: loadAll,
            child: Icon(CupertinoIcons.refresh),
          )),
      child: ListView(
        children: [
          if (families == null)
            ListTile(title: Text("Loading"))
          else
            for (var fam in families!)
              RefTile(
                ref: fam.tribe,
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
                    return FamilyPage(family: fam);
                  }));
                },
              )
        ],
      ),
    );
  }

  Future loadAll() async {
    families = await context.familyApi.list();
    setState(() {});
  }
}
