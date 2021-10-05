import 'package:example/graphql_stuff.dart';
import 'package:example/pages/contacts_page.dart';
import 'package:example/pages/families_page.dart';
import 'package:example/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoApp(
        title: 'Graph Stuff',
        home: MyHomePage(title: 'Graph Stuff Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return GraphQLProviders(
      builder: (BuildContext context) => DefaultTabController(
        length: 2,
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            onTap: (tab) {
              if (tab != _tab) {
                setState(() {
                  this._tab = tab;
                });
              }
            },
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet), label: "Contacts"),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: "Families"),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return index == 1 ? FamiliesPage() : ContactsPage();
          },
        ),
      ),
    );
  }
}
