import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fubalapp_mobile/league_widget.dart';
import 'package:fubalapp_mobile/player_widget.dart';
import 'addGame_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';


GlobalKey globalKey = GlobalKey();

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
  PageController _pageController;

  int _currentIndex = 0;

  List<Widget> _children = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  void initState() {
    super.initState();
    _children = [
      League(),
      Player(),
    ];
    _pageController = PageController();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
          () => _animationController.forward(),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


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
      extendBody: true,
      backgroundColor: Colors.blueGrey.shade50,
      body: PageView(
          physics:new NeverScrollableScrollPhysics(),
          controller: _pageController,
          allowImplicitScrolling: false,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: _children
      ),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          onPressed: addGame,
          child: Icon(Icons.add),
          backgroundColor: Colors.tealAccent.shade400,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          MaterialCommunityIcons.tournament,
          MaterialCommunityIcons.face
        ],
        splashColor: Colors.pinkAccent,
        activeColor: Colors.tealAccent.shade700,
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        notchAndCornersAnimation: animation,
        leftCornerRadius: 16,
        rightCornerRadius: 16,
        splashSpeedInMilliseconds: 400,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.easeOut);
        }),
        //other params
      ),
    );
  }


  void addGame() {
    _animationController.reset();
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 450,
        child: Scaffold(body:AddGame()),
      )
    );
    _animationController.forward();
  }
}