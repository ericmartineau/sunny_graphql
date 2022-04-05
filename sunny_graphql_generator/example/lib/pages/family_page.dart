import 'package:example/providers.dart';
import 'package:flexidate/flexible_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunny_graphql/refs.dart';

import '../graphql_stuff.dart';
import '../ref_tile.dart';

class FamilyPage extends StatefulWidget {
  final FamilyTribe family;

  const FamilyPage({Key? key, required this.family}) : super(key: key);

  @override
  _FamilyPageState createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  List<JoinRecord<Fact, Tribe, FactParticipant>> _facts = [];
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
        trailing: Row(
          children: [
            CupertinoButton(
              child: Icon(CupertinoIcons.refresh),
              onPressed: loadAll,
            ),
            CupertinoButton(
              child: Icon(CupertinoIcons.add),
              onPressed: addMemory,
            ),
          ],
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
    final contactApi = context.tribeApi;
    final facts = await contactApi.loadFactsForRecord(widget.family.tribe.id);
    setState(() {
      this._facts = [
        for (var fact in facts) fact.cast2<Fact, Tribe>(),
      ];
    });
  }

  Future addMemory() async {
    MemoryApi memories = Provider.of(context, listen: false);
    ContactApi contactsApi = Provider.of(context, listen: false);
    late MemoryCreateInput memoryCreateInput;
    final contacts = [
      ...widget.family.children,
      ...widget.family.parents,
    ];
    memoryCreateInput = MemoryCreateInput(
      participants: MemoryParticipantRefList.list(connect: [
        for (var c in contacts) ExtGraphRef.connect(c.id, FactParticipant()),
      ]),
      displayName: "My fancy memory",
      factDate: FlexiDate.now(),
      location: GraphRef.create(
        PhysicalLocationCreateInput(
          displayName: "My House",
          id: "freeburg",
          lat: 34.0,
          lon: 153.0,
        ),
      ),
      imageMedia: MemoryImageMediumRefList.single(
        connect: MemoryImageMediumRef.create(
          ImageMediaCreateInput(
            height: 800.0,
            width: 1200.0,
            aspect: .6,
            caption: "Last year's party",
            mediaUrl: Uri.parse('https://someimage.com'),
            mediaType: MediaType.IMAGE,
            fileName: "last-years-party.png",
            // orientation: Orientation.PORTRAIT,
          ),
          MediaSelection(sortOrder: 0),
        ),
      ),
      videoMedia: MemoryVideoMediumRefList.single(
        connect: MemoryVideoMediumRef.create(
          VideoMediaCreateInput(
            height: 800.0,
            width: 1200.0,
            aspect: .6,
            caption: "Last year's party",
            mediaUrl: Uri.parse('https://someimage.com'),
            mediaType: MediaType.VIDEO,
            fileName: "last-years-party.mp4",
            // orientation: Orientation.PORTRAIT,
            durationMs: 30000,
          ),
          MediaSelection(
            sortOrder: 0,
          ),
        ),
      ),
    );
    final memoryCreate = await memories.create(
      memoryCreateInput,
    );
    // print(loadedUser.toMap());
  }
}
