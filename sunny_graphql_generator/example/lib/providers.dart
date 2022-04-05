import 'package:example/primitive_serializers.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:logging/logging.dart';
import 'package:logging_config/logging_config.dart';
import 'package:provider/provider.dart';
import 'package:sunny_graphql/graph_client_config.dart';
import 'package:sunny_graphql/graph_client_serialization.dart';
import 'package:sunny_sdk_core/data.dart';

import 'graphql_stuff.dart';

class GraphQLProviders extends StatefulWidget {
  final WidgetBuilder builder;

  const GraphQLProviders({Key? key, required this.builder}) : super(key: key);
  @override
  _GraphQLProvidersState createState() => _GraphQLProvidersState();
}

class _GraphQLProvidersState extends State<GraphQLProviders> {
  late GraphQLClient client;

  late ContactApi contactsApi;
  late TribeApi tribeApi;
  late UserContactApi userApi;
  late FamilyTribeApi familyApi;

  @override
  void initState() {
    super.initState();

    configureLogging(LogConfig.root(Level.INFO));
    var httpLink = HttpLink("http://0.0.0.0:4001/graphql");

    client = new GraphQLClient(link: httpLink, cache: new GraphQLCache());
    var resolver = ReliveItQueryResolver();

    final serializer = FactoryGraphSerializer()

      // ..addWriter((name) => (name.contains("RefCreate") || name.contains("RefUpdate"))
      //     ? (data) {
      //         return data is GraphRefInput ? data.toJson() : throw "Invalid ref input.  Must provide a value";
      //       }
      //     : null)
      ..addReader(GraphQLStuffJson().getReader)
      ..addWriter(GraphQLStuffJson().getWriter)
      ..addWriter(ReliveItGraphQLSerializers.primitiveWriter)
      ..addReader(ReliveItGraphQLSerializers.primitiveReader);
    final events = RecordEventService();
    GraphClientConfig.init(client, serializer: serializer);
    contactsApi = ContactApi(() => client, resolver, serializer, events);
    userApi = UserContactApi(() => client, resolver, serializer, events);
    familyApi = FamilyTribeApi(() => client, resolver, serializer, events);
    tribeApi = TribeApi(() => client, resolver, serializer, events);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: familyApi),
        Provider.value(value: tribeApi),
        Provider.value(value: userApi),
        Provider.value(value: userApi),
        Provider.value(value: contactsApi),
      ],
      child: Builder(
        builder: widget.builder,
      ),
    );
  }
}

extension GraphApis on BuildContext {
  ContactApi get contactsApi => Provider.of(this, listen: false);
  UserContactApi get userApi => Provider.of(this, listen: false);
  FamilyTribeApi get familyApi => Provider.of(this, listen: false);
  TribeApi get tribeApi => Provider.of(this, listen: false);
}
