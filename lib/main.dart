import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fubalapp_mobile/services/QueryMutation.dart';
import 'package:fubalapp_mobile/utils/MyBehavior.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:splashscreen/splashscreen.dart';
import 'login_Widget.dart';
import "services/graphqlDataConf.dart";
import 'home_widget.dart';


GraphQLDataConfiguration graphQLConfiguration = GraphQLDataConfiguration();

void main() => runApp(
  GraphQLProvider(
    client: graphQLConfiguration.client,
    child: CacheProvider(child: App()),
  ),
);

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var storage = FlutterSecureStorage();
  String jwt;
  Widget _body = SplashScreen(
    seconds: 100,
    title: new Text('', style: TextStyle(
        fontFamily: "sweetPurple",
        fontSize: 80
      )
    ),
    image: new Image.asset('images/logo2.png'),
    backgroundColor: Colors.tealAccent.shade400,
    loaderColor: Colors.white,
    photoSize: 200,
  );

  void tryConnection() async {
    QueryMutation queryMutation = QueryMutation();
    await storage.read(key: "jwt").then((value) async {
      this.jwt = value;
      GraphQLClient _client =  GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: HttpLink(
            uri: "http://140.238.209.212:8080/query",
            headers: {
              "Authorization": jwt
            }
        ),
      );
      QueryResult result = await _client.query(
        QueryOptions(
          documentNode: gql(queryMutation.getLeagueData()),
        ),
      );
      if (!result.hasException) {
        debugPrint("Il token è ancora valido, salta l'autenticazione");
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            _body = Home();
          });
        });
      }
      else if (result.exception.clientException.message.contains("Invalid response body: Invalid token")){
        debugPrint("È necessario rieseguire l'autenticazione");
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            _body = LoginScreen();
          });
        });
      }
      else {
        debugPrint(result.exception.toString());
        Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            _body = LoginScreen();
          });
        });
      }
    });
  }

  @override
  initState() {
    super.initState();
    tryConnection();
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: MaterialColor(
            0xFF1DE9B6,
            {
              50:Color.fromRGBO(29,233,182, .1),
              100:Color.fromRGBO(29,233,182, .2),
              200:Color.fromRGBO(29,233,182, .3),
              300:Color.fromRGBO(29,233,182, .4),
              400:Color.fromRGBO(29,233,182, 1),
              500:Color.fromRGBO(29,233,182, .6),
              600:Color.fromRGBO(29,233,182, .7),
              700:Color.fromRGBO(29,233,182, .8),
              800:Color.fromRGBO(29,233,182, .9),
              900:Color.fromRGBO(29,233,182, 1),
            }
        ),
        accentColor: Colors.pinkAccent,
        cursorColor: Colors.pinkAccent,
        textTheme: TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.white,
          ),
          button: TextStyle(
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      home: _body,

    );
  }
  
}

