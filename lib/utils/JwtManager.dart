import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtManager {

  String jwt;
  var storage = FlutterSecureStorage();

  init() async{
    Future.delayed(Duration(milliseconds: 500)).then((_) async {
      await storage.read(key: "jwt").then((value) => {this.jwt = value});
    });
  }

  String getCurrentUserJwt() {
    return jwt;
  }
}