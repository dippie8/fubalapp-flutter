import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fubalapp_mobile/models/Teammate.dart';

class TeamMateCard extends StatelessWidget {

  final Teammate teammate;


  TeamMateCard(this.teammate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(FontAwesome.user, size: 32, color: Colors.blueGrey.shade800),
                Text("    " + teammate.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.blueGrey.shade800),),
              ],
            )
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesome5.handshake, color: Colors.blueGrey.shade800, size: 29,),
                                Text("   " + teammate.gamesTogether.toString(), style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade800)),
                                ],
                            ),
                            Text("giocate insieme", style: TextStyle(color: Colors.blueGrey.shade800),),
                          ]
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesome.trophy, color: Colors.blueGrey.shade800, size: 29,),
                                Text("  " + teammate.winTogether.toString(), style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade800)),
                              ],
                            ),
                            Text("vinte insieme", style: TextStyle(color: Colors.blueGrey.shade800),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(customDivision(teammate.winTogether, teammate.gamesTogether) >= 0.5 ? FontAwesome.thumbs_up : FontAwesome.thumbs_down, color: customDivision(teammate.winTogether, teammate.gamesTogether) >= 0.5 ? Colors.green : Colors.red, size: 35,),
                        Text(" " + ( customDivision(teammate.winTogether, teammate.gamesTogether) * 100).round().toString() + "%", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: customDivision(teammate.winTogether, teammate.gamesTogether) >= 0.5 ? Colors.green : Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Column(
                  children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            children: [
                              Row(
                                  children: [
                                    Icon(MaterialCommunityIcons.sword_cross, color: Colors.blueGrey.shade800, size: 29,),
                                    Text("  " + teammate.gamesAgainst.toString(), style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade800)),
                                  ],
                              ),
                              Text("giocate contro", style: TextStyle(color: Colors.blueGrey.shade800),),
                            ]
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesome.trophy, color: Colors.blueGrey.shade800, size: 29,),
                                Text("  " + teammate.winAgainst.toString(), style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade800)),
                              ],
                            ),
                            Text("vinte contro", style: TextStyle(color: Colors.blueGrey.shade800),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(customDivision(teammate.winAgainst, teammate.gamesAgainst) >= 0.5 ? FontAwesome.thumbs_up : FontAwesome.thumbs_down, color: customDivision(teammate.winAgainst, teammate.gamesAgainst) >= 0.5 ? Colors.green : Colors.red, size: 35,),
                        Text(" " + (customDivision(teammate.winAgainst, teammate.gamesAgainst) * 100).round().toString() + "%", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: customDivision(teammate.winAgainst, teammate.gamesAgainst) >= 0.5 ? Colors.green : Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double customDivision(int a, int b) {
    if( b == 0) {
      return 0;
    } else {
      return a/b;
    }
  }
}