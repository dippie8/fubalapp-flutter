import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fubalapp_mobile/league_components/standingView.dart';
import 'package:fubalapp_mobile/models/Game.dart';
import 'package:fubalapp_mobile/models/MedalTable.dart';
import 'package:fubalapp_mobile/models/Standing.dart';
import 'package:fubalapp_mobile/services/QueryMutation.dart';
import 'package:fubalapp_mobile/services/graphqlDataConf.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'league_components/lastMatches.dart';
import 'league_components/medalTableView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'login_Widget.dart';


class League extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LeagueState();
  }

}

class _LeagueState extends State<League> {


  var storage = FlutterSecureStorage();

  String numPlayers;

  List<Standing> standings = [
    Standing("#909090", "", 0, 0, 0),
    Standing("#909090", "", 0, 0, 0),
    Standing("#909090", "", 0, 0, 0),
    Standing("#909090", "", 0, 0, 0),
    Standing("#909090", "", 0, 0, 0),
  ];

  bool standingModePercentage = false;

  List<Game> games = [
    Game("", "", "", "", "#909090", "#909090", "#909090", "#909090", "1990-01-01 00:00", 0, 0, 0),
    Game("", "", "", "", "#909090", "#909090", "#909090", "#909090", "1990-01-01 00:00", 0, 0, 0),
    Game("", "", "", "", "#909090", "#909090", "#909090", "#909090", "1990-01-01 00:00", 0, 0, 0),
  ];
  List<MedalTableRow> medalTableRows = [];

  GraphQLDataConfiguration graphQLConfiguration = GraphQLDataConfiguration();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // _LeagueState(this.standings);


  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      child: CustomScrollView(
        slivers: <Widget>[
          standing(),
          lastMatch(),
          medalTable(),
          SliverToBoxAdapter(child: SizedBox(height: 100))
        ],
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropMaterialHeader(color: Colors.white ,backgroundColor: Colors.tealAccent.shade400),
    );
  }

  void getPlayersNumber() async {
    await storage.read(key: "players").then((value) async {
      this.numPlayers = value;
      print("ho letto dallo storage: " + numPlayers);
    });

    setState(() {
      standings.clear();
      for(int i=0; i < int.parse(this.numPlayers); i++) {
        this.standings.add(
            Standing("#909090", "", 0, 0, 0)
        );
      }
    });


  }

  @override
  void initState() {
    getPlayersNumber();
    super.initState();
    loadData();
    // Future.delayed(Duration(milliseconds: 200)).then((_) async {
    //   loadData();
    // });

  }

  Widget standing() => SliverToBoxAdapter(
    child: StandingView(standings, standingModePercentage, () {
      setState(() {
        standingModePercentage = !standingModePercentage;

      });
    }),
  );

  Widget lastMatch() => SliverToBoxAdapter(
    child: LastMatch(games),
  );

  Widget medalTable() => SliverToBoxAdapter(
    child: MedalTableView(medalTableRows),
  );

  void loadData({cycle: 0}) async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queryMutation.getLeagueData()),
      ),
    );
    if (!result.hasException) {

      standings.clear();
      for (var i = 0; i < result.data["standings"].length; i++) {
        setState(() {
          standings.add(
            Standing(
              result.data["standings"][i]["color"],
              result.data["standings"][i]["username"],
              result.data["standings"][i]["win"],
              result.data["standings"][i]["played"],
              result.data["standings"][i]["elo"],
            ),
          );
        });
      }

      storage.write(key: "players", value: result.data["standings"].length.toString());

      medalTableRows.clear();
      for (var i = 0; i < result.data["players"].length; i++) {
        setState(() {
          medalTableRows.add(
              MedalTableRow(
                result.data["players"][i]["username"],
                result.data["players"][i]["goldMedals"],
                result.data["players"][i]["silverMedals"],
                result.data["players"][i]["bronzeMedals"],
              )
          );
        });
      }

      games.clear();
      for (var i = 0; i < result.data["games"].length; i++) {
        setState(() {
          games.add(
              Game(
                result.data["games"][i]["player1"]['username'],
                result.data["games"][i]["player2"]['username'],
                result.data["games"][i]["player3"]['username'],
                result.data["games"][i]["player4"]['username'],
                result.data["games"][i]["player1"]['color'],
                result.data["games"][i]["player2"]['color'],
                result.data["games"][i]["player3"]['color'],
                result.data["games"][i]["player4"]['color'],
                result.data["games"][i]["id"].substring(0, 16),
                result.data["games"][i]["deltaPoints"],
                result.data["games"][i]["score12"],
                result.data["games"][i]["score34"],
              )
          );
        });
      }
    }
    else if (result.exception.clientException.message.contains("Invalid response body: Invalid token")){
      if(cycle == 0) {
        await Future.delayed(Duration(milliseconds: 1000));
        loadData(cycle: 1);
      }
      else
        // Navigator.of(context).pushReplacementNamed('/').then((_) => false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
    }
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    loadData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    //if(mounted)
    //   loadData();
    _refreshController.loadComplete();
  }

}