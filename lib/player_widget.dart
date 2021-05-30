import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fubalapp_mobile/player_components/pieChart.dart';
import 'package:fubalapp_mobile/player_components/teamMates.dart';
import 'package:fubalapp_mobile/services/QueryMutation.dart';
import 'package:fubalapp_mobile/services/graphqlDataConf.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'league_components/lastMatches.dart';
import 'login_Widget.dart';
import 'models/Game.dart';
import 'models/Teammate.dart';

class Player extends StatefulWidget {
    @override
  State<StatefulWidget> createState() {
    return _PlayerState();
  }
}

class _PlayerState extends State<Player> {

  GraphQLDataConfiguration graphQLConfiguration = GraphQLDataConfiguration();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<String> players = [];
  String currentUser = 'Giocatore';
  List<Game> games = [];
  List<Teammate> teammates = [
    Teammate("Nome", 0, 0, 0, 0)
  ];
  double wins=50;
  double played=100;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: SizedBox(height: 50)),
          picker(),
          winPie(),
          otherPlayers(),
          lastMatch(),
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

  @override
  void initState() {
    super.initState();
    loadPlayersList();
    var storage = FlutterSecureStorage();
    Future.delayed(Duration(milliseconds: 500)).then((_) async {
      await storage.read(key: "user").then((value) => {
        setState(() {
        currentUser = value;
        loadPlayerData(currentUser);
        })
      });
    });
  }

  Widget picker() => SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListTile(
        leading: Icon(MaterialCommunityIcons.face_recognition, size: 50, color: Colors.black54,),
        title: Text(currentUser),
        subtitle: Text("clicca per cambiare giocatore"),
        trailing: Icon(Icons.edit),
        onLongPress: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            // return alert dialog object
            return AlertDialog(
                title: new Text('Vuoi uscire da questo account?', style: TextStyle(color: Colors.black87),),
                content: Container(
                    height: 100.0, // Change as per your requirement
                    width: 300.0, // Change
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    child: RaisedButton(
                      padding: EdgeInsets.all(20),
                      onPressed: () {
                        // Navigator.of(context).pushReplacementNamed('/').then((_) => false);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false,
                        );
                      },
                      color: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Esci'.toUpperCase(), style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                )
            );
          },
        ),
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            // return alert dialog object
            return AlertDialog(
              title: new Text('Seleziona un giocatore', style: TextStyle(color: Colors.pink),),
              content: Container(
                height: 300.0, // Change as per your requirement
                width: 300.0, // Change as per your requirement
                child: Scrollbar(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: players.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text(players[index]),
                          onTap: () {
                            setState(() {
                              currentUser = players[index];
                              loadPlayerData(currentUser);
                              Navigator.pop(context);
                            });
                          }
                      );
                    },
                  ),
                )
              )
            );
          },
        )
      ),
    )
  );

  Widget winPie() => SliverToBoxAdapter(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text(
                "Dati Carriera",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        MyPieChart(wins.toInt(), played.toInt()),
      ],
    )
  );

  Widget lastMatch() => SliverToBoxAdapter(
    child: LastMatch(games),
  );

  Widget otherPlayers() => SliverToBoxAdapter(
    child: Teammates(teammates),
  );

  void loadPlayersList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queryMutation.getPlayersList()),
      ),
    );
    if (!result.hasException) {
      players.clear();
      for (var i = 0; i < result.data["players"].length; i++) {
        setState(() {
          players.add(result.data["players"][i]["username"]);
        });
      }
      players.sort();
    }
  }

  void loadPlayerData(String player, {cycle: 0}) async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queryMutation.getPlayerData(player)),
      ),
    );
    if (!result.hasException) {
      wins = result.data['players'][0]['careerWin'].toDouble();
      played = result.data['players'][0]['careerPlayed'].toDouble();

      if(wins == 0 && played == 0) {
        teammates.clear();
        games.clear();
        setState(() {
          teammates.add(
            Teammate("Nome", 0, 0, 0, 0)
          );
          for(int i = 0; i < 3; i++)
            games.add(
              Game("", "", "", "", "#909090", "#909090", "#909090", "#909090", "1990-01-01 00:00", 0, 0, 0),
            );
        });
      }
      else {
        teammates.clear();
        for (var i = 0; i < result.data['players'][0]['teammates'].length; i++) {
          setState(() {
            teammates.add(
                Teammate(
                  result.data['players'][0]['teammates'][i]['username'],
                  result.data['players'][0]['teammates'][i]['winTogether'],
                  result.data['players'][0]['teammates'][i]['gamesTogether'],
                  result.data['players'][0]['teammates'][i]['winAgainst'],
                  result.data['players'][0]['teammates'][i]['gamesAgainst'],
                )
            );
          });
        }

        games.clear();
        for (var i = 0; i < result.data['games'].length; i++) {
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
    }
    else if (result.exception.clientException.message.contains("Invalid response body: Invalid token")){
      if(cycle == 0) {
        await Future.delayed(Duration(milliseconds: 1000));
        loadPlayerData(currentUser, cycle: 1);
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
    loadPlayerData(currentUser);
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
