import 'dart:convert';

import 'package:example/graphql_stuff.dart';
import 'package:example/primitive_serializers.dart';
import 'package:flexidate/flexidate.dart';
import 'package:sunny_sdk_core/data.dart';

import 'package:graphql/client.dart';
import 'package:logging/logging.dart';
import 'package:logging_config/logging_config.dart';
import 'package:sunny_graphql/sunny_graphql.dart';
import 'package:test_api/test_api.dart';

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
  final events = RecordEventService();
  final contacts = ContactApi(() => client, resolver, serializer, events);
  final memories = MemoryApi(() => client, resolver, serializer, events);
  final specialEventApi = SpecialEventApi(() => client, resolver, serializer, events);
  final uc = UserContactApi(() => client, resolver, serializer, events);
  final ft = FamilyTribeApi(() => client, resolver, serializer, events);
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

    late MemoryCreateInput memoryCreateInput;
    try {
      memoryCreateInput = MemoryCreateInput(
        participants: MemoryParticipantRefList.list(connect: [
          MemoryParticipantRef.connect(contact1.id, FactParticipant()),
          MemoryParticipantRef.connect(contact2.id, FactParticipant()),
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
              orientation: Orientation.PORTRAIT,
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
              orientation: Orientation.PORTRAIT,
              durationMs: 30000,
            ),
            MediaSelection(sortOrder: 0),
          ),
        ),
      );
      final memoryCreate = await memories.create(
        memoryCreateInput,
      );

      late SpecialEventCreateInput specialEventCreateInput;

      specialEventCreateInput = SpecialEventCreateInput(
          participants: ExtGraphRefList.list(connect: [
            ExtGraphRef.connect(contact1.id, FactParticipant()),
            ExtGraphRef.connect(contact2.id, FactParticipant()),
          ]),
          displayName: "My fancy memory",
          factDate: FlexiDate.now(),
          eventDetails: "This event was speeecial",
          isAnnual: true);
      final specialEventCreate = await specialEventApi.create(specialEventCreateInput);
      // print(loadedUser.toMap());

      _log.warning(specialEventCreate.toMap());
      final contactFacts = await contacts.loadFactsForRecord(contact1.id);
      final contact2Facts = await contacts.loadFactsForRecord(contact2.id);
      expect(contactFacts, hasLength(2));
      expect(contact2Facts, hasLength(2));

      expect(contactFacts.map((f) => f.node).whereType<Memory>(), hasLength(1));
      expect(contactFacts.map((f) => f.node).whereType<SpecialEvent>(), hasLength(1));

      final start = DateTime.now();
      final contactFacts2 = await contacts.loadFactsForRecord(contact1.id);
      final contact2Facts2 = await contacts.loadFactsForRecord(contact2.id);
      print("Completed lookups second time in ${DateTime.now().millisecondsSinceEpoch - start.millisecondsSinceEpoch}ms");
    } on Exception catch (e, stack) {
      final memoryInputStr = json.encode(memoryCreateInput.toJson());
      print(memoryInputStr);
      print(e);
      print(stack);
      rethrow;
    }
  });
}
