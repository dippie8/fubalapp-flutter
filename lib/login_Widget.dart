import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fubalapp_mobile/home_widget.dart';
import 'package:fubalapp_mobile/services/QueryMutation.dart';
import 'package:fubalapp_mobile/services/graphqlLoginConf.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


class LoginScreen extends StatelessWidget {
  // static const routeName = '/auth';
  GraphQLLoginConfiguration graphQLConfiguration = GraphQLLoginConfiguration();
  Duration get loginTime => Duration(milliseconds: 1000);
  final storage = FlutterSecureStorage();

  Future<String> _login(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      QueryMutation queryMutation = QueryMutation();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.login(data.name, data.password)),
        ),
      );
      if (!result.hasException) {
        var jwtToken = result.data["login"];
        await storage.write(key: "jwt", value: jwtToken);
        await storage.write(key: "user", value: data.name);
        return null;
      }
      return "Utente e password non sono corretti, riprova";

    });
  }


  Future<String> _signup(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      QueryMutation queryMutation = QueryMutation();
      GraphQLClient _client = graphQLConfiguration.clientToQuery();
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.signUp(data.name, data.password)),
        ),
      );
      if (!result.hasException) {
        var jwtToken = result.data["login"];
        await storage.write(key: "jwt", value: jwtToken);
        await storage.write(key: "user", value: data.name);
        return _login(data);
      }
      return "Si è verificato un errore oppure esiste già un utente con lo stesso nome";

    });
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.tealAccent.shade400,
            systemNavigationBarColor: Colors.tealAccent.shade400,
            systemNavigationBarIconBrightness: Brightness.light
        )
    );

    return FlutterLogin(
      title: 'FUBALAPP',
      theme: LoginTheme(
        titleStyle: TextStyle(
          fontFamily: "CoreSans",
          fontSize: 50
        )
      ),
      // logo: 'images/logo.jpg',
      onLogin: _login,
      onSignup: _signup,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
      onRecoverPassword: (_) => null,
      emailValidator: (_sds) => null,
      passwordValidator: (_) => null,
      messages: LoginMessages(
        usernameHint: 'Nome Utente',
        passwordHint: 'Password',
        confirmPasswordHint: 'Conferma Password',
        loginButton: 'ACCEDI',
        signupButton: 'REGISTRATI',
        forgotPasswordButton: 'Password dimenticata',
        recoverPasswordButton: 'AIUTO',
        goBackButton: 'TORNA INDIETRO',
        confirmPasswordError: 'Username e password non corrispondono!',
        recoverPasswordDescription:
        'Il servizio di recupero password non è ancora attivo',
        recoverPasswordSuccess: 'La tua richiesta è stata ignorata, contatta Dippi',
      ),
    );
  }
}