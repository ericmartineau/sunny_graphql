import 'package:example/graphql_stuff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:flexidate/flexidate.dart';
import 'package:logging/logging.dart';
import 'package:logging_config/logging_config.dart';
import 'package:sunny_graphql/graph_client_config.dart';
import 'package:sunny_graphql/graph_client_serialization.dart';
import 'package:sunny_graphql/refs.dart';

Future main() async {
  var client = new GraphQLClient(link: HttpLink("http://localhost"), cache: new GraphQLCache());
  var resolver = ReliveItQueryResolver();
  final serializer = FactoryGraphSerializer()

    // ..addWriter((name) => (name.contains("RefCreate") || name.contains("RefUpdate"))
    //     ? (data) {
    //         return data is GraphRefInput ? data.toJson() : throw "Invalid ref input.  Must provide a value";
    //       }
    //     : null)
    ..addReader(GraphQLStuffJson().getReader)
    ..addWriter((name) => name != 'FlexiDate' ? null : ((flexiDate) => (flexiDate as FlexiDate).toJson()))
    ..addWriter(GraphQLStuffJson().getWriter);
  GraphClientConfig.init(client, serializer: serializer);
  configureLogging(LogConfig.root(Level.INFO));

  test("input starts with blank json", () {
    final phase = PhaseCreateInput();
    expect(phase.toJson(), isNotNull);
    expect(phase.toJson()!, equals(<String, dynamic>{}));
  });

  test("input adds fields when they are edited", () {
    final phase = PhaseCreateInput();
    phase.displayName = "My Display Name";
    phase.startDate = FlexiDate.of(day: 28, month: 12);

    expect(phase.toJson(), isNotNull);
    expect(
        phase.toJson()!,
        equals(<String, dynamic>{
          'displayName': 'My Display Name',
          'startDate': '12-28',
        }));
  });

  test("input adds fields when they are edited", () {
    final phase = PhaseCreateInput();
    phase.displayName = "My Display Name";
    phase.startDate = FlexiDate.of(day: 28, month: 12);

    expect(phase.toJson(), isNotNull);
    expect(
        phase.toJson()!,
        equals(<String, dynamic>{
          'displayName': 'My Display Name',
          'startDate': '12-28',
        }));
  });

  test("input adds type wrapper", () {
    final phase = PhaseCreateInput();
    // phase.phased = GraphRef.connect('1234', 'Contact');
    expect(phase.toJson(), isNotNull);
    expect(
        phase.toJson()!,
        equals(<String, dynamic>{
          'phased': {
            'Contact': {
              'connect': {
                'where': {
                  'node': {'id': '1234'}
                }
              },
              'disconnect': {
                'where': {
                  'node': {'id_NOT': '1234'}
                }
              }
            }
          }
        }));
  });

  test("input adds special connection fields", () {
    final tribe = TribeCreateInput();
    tribe.members = ExtGraphRefList.single(
        connect: ExtGraphRef.connect(
            "1234",
            TribeMemberDetails(
              joined: false,
              isAdmin: true,
              requested: true,
            )));
    tribe.displayName = "My Display Name";

    expect(tribe.toJson(), isNotNull);
    expect(
      tribe.toJson()!,
      equals(
        <String, dynamic>{
          "displayName": 'My Display Name',
          'members': {
            'connect': [
              {
                'where': {
                  'node': {'id': '1234'}
                },
                'edge': {
                  'node': null,
                  'joined': false,
                  'requested': true,
                  'role': null,
                  'isAdmin': true,
                }
              }
            ]
          }
        },
      ),
    );
  });

  test("UpdateInput relatedJson adds special connection fields", () {
    final tribe = TribeUpdateInput();
    tribe.members = TribeMemberRefList.list(connect: [
      ExtGraphRef.connect(
        "1234",
        TribeMemberDetails(
          joined: false,
          isAdmin: true,
          requested: true,
        ),
      ),
      ExtGraphRef.create(
        ContactCreateInput()..displayName = "Billy Bobbers",
        TribeMemberDetails(
          joined: false,
          isAdmin: true,
          requested: true,
        ),
      )
    ]);
    tribe.displayName = "My Display Name";

    final combined = tribe.toJson();
    expect(combined, isNotNull);
    expect(
        combined,
        equals(<String, dynamic>{
          'displayName': 'My Display Name',
          'members': {
            'connect': [
              {
                'where': {
                  'node': {'id': '1234'}
                },
                'edge': {
                  'node': null,
                  'joined': false,
                  'requested': true,
                  'role': null,
                  'isAdmin': true,
                }
              }
            ],
            'create': [
              {
                'node': {'displayName': 'Billy Bobbers'},
                'edge': {
                  'node': null,
                  'joined': false,
                  'requested': true,
                  'role': null,
                  'isAdmin': true,
                }
              }
            ],
          }
        }));
  });
  test("input relatedJson handles relationships", () {
    final tribeInput = FamilyTribeCreateInput(
      tribe: GraphRef.connect("1234"),
      children: GraphRefList(connect: [
        GraphRef.connect("billy@bob.com"),
      ], disconnect: [
        "richard@foo.com",
      ]),
    );

    final res = tribeInput.toJson();
    expect(
      res,
      equals(
        {
          'tribe': {
            'disconnect': {
              'where': {
                'node': {'id_NOT': '1234'}
              }
            },
            'connect': {
              'where': {
                'node': {'id': '1234'}
              }
            }
          },
          'children': {
            'connect': {
              'where': {
                'node': {
                  'id_IN': ['billy@bob.com']
                }
              }
            }
          },
        },
      ),
    );
  });
}
