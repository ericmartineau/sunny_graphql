import 'package:example/graphql_stuff.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
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
    ..addWriter(GraphQLStuffJson().getWriter);
  GraphClientConfig.init(client, serializer: serializer);
  configureLogging(LogConfig.root(Level.INFO));

  test("input relatedJson handles relationships", () {
    final tribeInput = FamilyTribeCreateInput(
      tribe: GraphRef.connect("1234"),
      children: GraphRefList(connect: [
        GraphRef.connect("billy@bob.com"),
      ], disconnect: [
        "richard@foo.com",
      ]),
    );

    final res = tribeInput.relatedJson();
    expect(
      res,
      equals(
        {
          'disconnect': {
            'tribe': {
              'where': {
                'node': {'id_NOT': '1234'}
              }
            },
            'children': {
              'where': {
                'node': {
                  'id_IN': ['richard@foo.com']
                }
              }
            }
          },
          'connect': {
            'tribe': {
              'where': {
                'node': {'id': '1234'}
              }
            },
            'children': {
              'where': {
                'node': {
                  'id_IN': ['billy@bob.com']
                }
              }
            },
          }
        },
      ),
    );
  });
}
