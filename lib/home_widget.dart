import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fubalapp_mobile/league_widget.dart';
import 'package:fubalapp_mobile/player_widget.dart';
import 'addGame_widget.dart';
import 'placeholder_widget.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';


GlobalKey globalKey = GlobalKey();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    League(),

    /* null containers */
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.white),
    /* null containers */

    Player(),
  ];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.white,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark
        )
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blueGrey.shade50,
      body: _children[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: addGame,
        child: Icon(Icons.add),
        backgroundColor: Colors.tealAccent.shade400,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        // fabLocation: BubbleBottomBarFabLocation.center, //new
        hasNotch: false, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(backgroundColor: Colors.tealAccent.shade700 /*Colors.tealAccent.shade700*/, icon: Icon(MaterialCommunityIcons.tournament, color: Colors.blueGrey.shade800), activeIcon: Icon(MaterialCommunityIcons.tournament, color: Colors.blueGrey.shade800), title: Text("Torneo")),
          BubbleBottomBarItem(backgroundColor: Colors.transparent, icon: Icon(Icons.dashboard, color: Colors.transparent,), title: Text("")),
          BubbleBottomBarItem(backgroundColor: Colors.transparent, icon: Icon(Icons.dashboard, color: Colors.transparent,), title: Text("")),
          BubbleBottomBarItem(backgroundColor: Colors.tealAccent.shade700 /*Colors.tealAccent.shade700*/, icon: Icon(MaterialCommunityIcons.face, color: Colors.blueGrey.shade800), activeIcon: Icon(MaterialCommunityIcons.face_recognition, color: Colors.blueGrey.shade800), title: Text("Giocatore"))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if(index == 0 || index == 1)
        _currentIndex = 0;
      else
        _currentIndex = 3;
    });
  }

  void addGame() {
        showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: 450,
          child: Scaffold(body:AddGame()),
        )
    );
  }
}