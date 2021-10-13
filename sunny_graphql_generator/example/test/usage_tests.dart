import 'package:example/graphql_stuff.dart';
import 'package:example/primitive_serializers.dart';
import 'package:flutter/cupertino.dart' hide Orientation;
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:flexidate/flexidate.dart';
import 'package:logging/logging.dart';
import 'package:logging_config/logging_config.dart';
import 'package:sunny_graphql/sunny_graphql.dart';

var gql = """
mutation addChild(\$familyId: ID! = null, \$contactId: ID! = null) {
  addChild(parentId: \$parentId, contactId: \$contactId) {
    displayName
  }
}
""";

final _log = Logger("Test");

Future main() async {
  configureLogging(LogConfig.root(Level.INFO));
  var httpLink = HttpLink("http://0.0.0.0:4001/graphql");

  var client = new GraphQLClient(link: httpLink, cache: new GraphQLCache());
  var resolver = ReliveItQueryResolver();
  final serializer = FactoryGraphSerializer()
    // ..addWriter((name) => (name.contains("RefCreate") || name.contains("RefUpdate"))
    //     ? (data) {
    //         return data is GraphRefInput ? data.toJson() : throw "Invalid ref input.  Must provide a value";
    //       }
    //     : null)
    ..addWriter((name) => name != 'Uri' ? null : (uri) => uri.toString())
    ..addReader((name) => name != 'Uri' ? null : (uri) => Uri.parse(uri.toString()))
    ..addReader(GraphQLStuffJson().getReader)
    ..addWriter(GraphQLStuffJson().getWriter)
    ..addReader(ReliveItGraphQLSerializers.primitiveReader)
    ..addWriter(ReliveItGraphQLSerializers.primitiveWriter);
  GraphClientConfig.init(client, serializer: serializer);
  final contacts = ContactApi(() => client, resolver, serializer);
  final memories = MemoryApi(() => client, resolver, serializer);
  final uc = UserContactApi(() => client, resolver, serializer);
  final ft = FamilyTribeApi(() => client, resolver, serializer);
  late String contactId;

  test("saves contact", () async {
    final deleted = await ft.delete("elm");
    final family = await ft.getOrCreate(
      "elm",
      create: () => FamilyTribeCreateInput(
        tribe: GraphRef.create(
          TribeCreateInput(
            id: "elm",
            displayName: "ELM Fam",
            slug: "elm-fam",
            tribeType: "Family",
          ),
        ),
      ),
    );

    var frenchyEmail = "frenchy44@gmail.com";
    var user = await uc.getOrCreate(
      frenchyEmail,
      create: () => UserContactCreateInput(
        id: frenchyEmail,
        contact: GraphRef.create(
          ContactCreateInput(
            displayName: "French Man",
            nickName: "French Barber",
          ),
        ),
        username: frenchyEmail,
        firebaseUid: "123123123",
      ),
    );

    // final loadedUser = await uc.load('frenchy44@gmail.com');
    _log.warning(user.contact.toMap());
    contactId = user.contact.id;
  });

  test("load child family", () async {
    final cfamily = await contacts.loadChildFamilyForRecord(contactId);
    _log.warning(cfamily?.toMap());
  });

  test("load parent family", () async {
    final pFamily = await contacts.loadParentFamilyForRecord(contactId);
    // print(loadedUser.toMap());

    _log.warning(pFamily?.toMap());
  });

  test("create memory", () async {
    final contact1 = await contacts.create(ContactCreateInput(
      displayName: "Billbert Boggins",
    ));
    final contact2 = await contacts.create(ContactCreateInput(
      displayName: "Billbert Boggins",
    ));
    final memoryCreat = await memories.create(
      MemoryCreateInput(
        contacts: GraphRefList(connect: [
          GraphRef.connect(contact1.id),
          GraphRef.connect(contact2.id),
        ]),
        displayName: "My fancy memory",
        memoryDate: FlexiDate.now(),
        location: GraphRef.create(
          PhysicalLocationCreateInput(
            displayName: "My House",
            id: "freeburg",
            lat: 34.0,
            lon: 153.0,
          ),
        ),
        imageMedia: GraphRefList(connect: [
          GraphRef.create(ImageMediaCreateInput(
            height: 800.0,
            width: 1200.0,
            aspect: .6,
            caption: "Last year's party",
            mediaUrl: Uri.parse('https://someimage.com'),
            mediaType: MediaType.IMAGE,
            fileName: "last-years-party.png",
            orientation: Orientation.PORTRAIT,
          ))
        ]),
        videoMedia: GraphRefList(connect: [
          GraphRef.create(VideoMediaCreateInput(
            height: 800.0,
            width: 1200.0,
            aspect: .6,
            caption: "Last year's party",
            mediaUrl: Uri.parse('https://someimage.com'),
            mediaType: MediaType.VIDEO,
            fileName: "last-years-party.mp4",
            orientation: Orientation.PORTRAIT,
            durationMs: 30000,
          ))
        ]),
      ),
    );
    // print(loadedUser.toMap());

    _log.warning(memoryCreat.toMap());

    final contactMemories = await contacts.loadMemoriesForRecord(contact1.id);
    final contact2Memories = await contacts.loadMemoriesForRecord(contact2.id);
    expect(contactMemories, hasLength(1));
    expect(contact2Memories, hasLength(1));

    expect(contactMemories!.first.id, equals(memoryCreat.id));
    expect(contact2Memories!.first.id, equals(memoryCreat.id));
  });
}
