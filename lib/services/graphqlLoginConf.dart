import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLLoginConfiguration {

  // final storage = FlutterSecureStorage();
  // storage.read(key: "jwt")

  static HttpLink httpLink = HttpLink(
      uri: "http://140.238.209.212:8080/query",
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink,

    );
  }
}