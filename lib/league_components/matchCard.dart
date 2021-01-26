import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fubalapp_mobile/models/Game.dart';
import 'package:fubalapp_mobile/utils/ColorConverter.dart';

class MatchCard extends StatelessWidget {

  final Game game;
  ColorConverter colorConverter = ColorConverter();

  MatchCard(this.game);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      borderOnForeground: true,
      color: Colors.white,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(FontAwesome.user, color: colorConverter.hexToColor(game.c1),size: 35),
                                Text(game.p1, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(FontAwesome.user, color: colorConverter.hexToColor(game.c2),size: 35),
                                Text(game.p2, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(game.score12.toString() + "-" + game.score34.toString(), style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700,),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    height: 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(FontAwesome.user, color: colorConverter.hexToColor(game.c3),size: 35),
                                Text(game.p3, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(FontAwesome.user, color: colorConverter.hexToColor(game.c4),size: 35),
                                Text(game.p4, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.17), BlendMode.dstATop),
                      image: AssetImage("images/campo2.jpg"), fit: BoxFit.cover)),

            ),
            SizedBox(height: 10),
            SizedBox(
              width: 265,
              child: Row(
                  children: [
                    Icon(MaterialIcons.date_range, size: 23, color: Colors.pink),
                    Text("   "),
                    Text(game.data, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),) // qui la data
                  ]
              )
            ),
            SizedBox(height: 10),
            SizedBox(
                width: 265,
                child: Row(
                    children: [
                      Icon(FontAwesome.line_chart, size: 20, color: Colors.pink),
                      Text("    "),
                      Text(game.deltaElo.toString(), style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),), // qui il delta ELO
                      Text(" punti assegnati", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),) // qui il delta ELO
                    ]
                )
            )
          ],
        ),
      )
    );
  }


}
