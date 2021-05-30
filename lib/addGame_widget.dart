import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fubalapp_mobile/services/QueryMutation.dart';
import 'package:fubalapp_mobile/services/graphqlDataConf.dart';
import 'package:fubalapp_mobile/utils/JwtManager.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flushbar/flushbar.dart';

class AddGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddGameState();
  }
}

class _AddGameState extends State<AddGame> {


  bool isButtonDisabled = false;

  GraphQLDataConfiguration graphQLConfiguration = GraphQLDataConfiguration();


  List<String> playerList = [];
  String _player1;
  String _player2;
  String _player3;
  String _player4;
  int _score12 = 0;
  int _score34 = 0;
  var j = JwtManager();

  @override
  void initState() {
    loadPlayersList();
    j.init();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MaterialCommunityIcons.numeric_1_box_multiple, color: Colors.black87,),
                              Text("  Squadra 1", style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.w500,),),
                            ],
                          ),
                          SizedBox(height: 30,),
                          DropdownButton<String>(
                            value: _player1,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black87),
                            underline: Container(
                              height: 2,
                              color: Colors.tealAccent.shade400,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _player1 = newValue;
                              });
                            },
                            items: playerList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20,),
                          DropdownButton<String>(
                            value: _player2,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black87),
                            underline: Container(
                              height: 2,
                              color: Colors.tealAccent.shade400,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _player2 = newValue;
                              });
                            },
                            items: playerList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20,),
                          NumberPicker.horizontal(
                            initialValue: _score12,
                            selectedTextStyle: TextStyle(color: Colors.tealAccent.shade700, fontSize: 25, fontWeight: FontWeight.w400),
                            minValue: 0,
                            maxValue: 20,
                            // decoration: BoxDecoration(
                            //   border: new Border(
                            //     top: new BorderSide(
                            //       style: BorderStyle.solid,
                            //       color: Colors.black26,
                            //     ),
                            //   )
                            // ),
                            onChanged: (num) {
                              setState(() {
                                _score12 = num;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MaterialCommunityIcons.numeric_2_box_multiple, color: Colors.black87,),
                              Text("  Squadra 2", style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.w500),),
                            ],
                          ),
                          SizedBox(height: 30,),
                          DropdownButton<String>(
                            value: _player3,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black87),
                            underline: Container(
                              height: 2,
                              color: Colors.tealAccent.shade400,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _player3 = newValue;
                              });
                            },
                            items: playerList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20,),
                          DropdownButton<String>(
                            value: _player4,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black87),
                            underline: Container(
                              height: 2,
                              color: Colors.tealAccent.shade400,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                _player4 = newValue;
                              });
                            },
                            items: playerList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 20,),
                          NumberPicker.horizontal(
                            initialValue: _score34,
                            selectedTextStyle: TextStyle(color: Colors.tealAccent.shade700, fontSize: 25, fontWeight: FontWeight.w400),
                            minValue: 0,
                            maxValue: 20,
                            onChanged: (num) {
                              setState(() {
                                _score34 = num;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: isButtonDisabled ? null : () { saveGame(); },
                    color: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text('Salva'.toUpperCase(), style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ],
              )
            ],
          )
      )
    );
  }

  void loadPlayersList() async {
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult result = await _client.query(
      QueryOptions(
        documentNode: gql(queryMutation.getPlayersList()),
      ),
    );
    if (!result.hasException) {
      playerList.clear();
      for (var i = 0; i < result.data["players"].length; i++) {
        setState(() {
          playerList.add(result.data["players"][i]["username"]);
        });
      }
      playerList.sort();
    }
  }

  void saveGame() async {
    setState(() {
      this.isButtonDisabled = true;
    });
    QueryMutation queryMutation = QueryMutation();
    GraphQLClient _client = graphQLConfiguration.clientToQuery();

    if (
        _player1 != _player2 &&
        _player1 != _player3 &&
        _player1 != _player4 &&
        _player2 != _player3 &&
        _player2 != _player4 &&
        _player3 != _player4 &&
        _score12 != _score34
    ) {
        QueryResult result = await _client.mutate(
          MutationOptions(
            documentNode: gql(queryMutation.addGame(_player1, _player2, _player3, _player4, _score12, _score34)),
          ),
        );

        if (!result.hasException) {
          Navigator.pop(context);
        } else {
          Flushbar(
            title:  "ERRORE!",
            message:  "Si è verificato un errore, controlla che i dati siano corretti e riprova",
            icon: Icon(
              MaterialCommunityIcons.alarm_light,
              size: 30.0,
              color: Colors.black,
            ),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.FLOATING,
            margin: EdgeInsets.all(8),
            borderRadius: 8,
            reverseAnimationCurve: Curves.decelerate,
            forwardAnimationCurve: Curves.elasticOut,
            duration:  Duration(seconds: 4),
            backgroundColor: Colors.pinkAccent,
            isDismissible: false,
          )..show(context);
        }
    } else {
      Flushbar(
        title:  "ERRORE!",
        message:  "Si è verificato un errore, controlla che i dati siano corretti e riprova",
        icon: Icon(
          MaterialCommunityIcons.alarm_light,
          size: 30.0,
          color: Colors.black,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        duration:  Duration(seconds: 4),
        backgroundColor: Colors.pinkAccent,
        isDismissible: false,
      )..show(context);
    }
    setState(() {
      this.isButtonDisabled = false;
    });
  }
}