import 'package:example/graphql_stuff.dart';
import 'package:graphql/client.dart';
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
    ..addReader(GraphQLStuffJson().getReader)
    ..addWriter(GraphQLStuffJson().getWriter);
  GraphClientConfig.init(client, serializer: serializer);
  final contacts = ContactApi(() => client, resolver, serializer);
  final uc = UserContactApi(() => client, resolver, serializer);
  final ft = FamilyTribeApi(() => client, resolver, serializer);
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
  final cfamily = await contacts.loadChildFamilyForContact(user.contact.id);
  final pFamily = await contacts.loadParentFamilyForContact(user.contact.id);

  // print(loadedUser.toMap());
  _log.warning(cfamily?.toMap());
  _log.warning(pFamily?.toMap());

  // final fv = await graphQL.childFamily(contactId: 'RVEHYmznVdeXD0H8ByNFITBnlkl1');
  // final user = await graphQL.mergeUser(
  //     user: UserInput(
  //         displayName: "Eric Martineua",
  //         nickName: "Eric",
  //         username: "smartytime@gmail.com",
  //         firebaseUid: "RVEHYmznVdeXD0H8ByNFITBnlkl1",
  //         email: "smartytime@gmail.com"),
  //     id: "RVEHYmznVdeXD0H8ByNFITBnlkl1");
  //
  // print("ContactID ${fv?.id}");

  throw "EError";
  // final fv2 = await graphQL.addChild(familyId: '1344', contactId: '3311');
  // print(fv2!.family);
  // print(fv2.contact);
}
