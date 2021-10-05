import 'package:example/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../graphql_stuff.dart';
import '../ref_tile.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact>? contacts;

  @override
  void initState() {
    super.initState();
    loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Contacts"),
        trailing: CupertinoButton(
          child: Icon(CupertinoIcons.refresh),
          onPressed: loadAll,
        ),
      ),
      child: ListView(
        children: <Widget>[
          if (contacts != null)
            for (var contact in contacts!) RefTile(ref: contact)
          else
            ListTile(title: Text("Loading Contacts")),
        ],
      ),
    );
  }

  Future loadAll() async {
    contacts = await context.contactsApi.list();
    setState(() {});
  }
}
