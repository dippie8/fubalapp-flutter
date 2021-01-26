import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fubalapp_mobile/utils/JwtManager.dart';
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLDataConfiguration {

  final storage = FlutterSecureStorage();
  static var jwtManager = JwtManager();


  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink(
          uri: "http://140.238.209.212:8080/query",
          headers: {
            "Authorization": jwtManager.getCurrentUserJwt()
          }
      ),
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: HttpLink(
          uri: "http://140.238.209.212:8080/query",
          headers: {
            "Authorization": jwtManager.getCurrentUserJwt()
          }
      ),
    );
  }

  GraphQLDataConfiguration() {
    jwtManager.init();
  }
}