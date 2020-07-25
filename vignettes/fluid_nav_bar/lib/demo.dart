import 'package:flutter/material.dart';

import './content/account.dart';
import './content/grid.dart';
import './content/home.dart';
import './fluid_nav_bar.dart';
import 'constants.dart';
import 'content/account.dart';
import 'content/stopwatch.dart';

class FluidNavBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _FluidNavBarDemoState();
  }
}

class _FluidNavBarDemoState extends State {
  Widget _child;

  @override
  void initState() {
    _child = HomeContent();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Constants.darkBackgroundColor, // Color(0xFF75B7E1),
          extendBody: true,
          body: _child,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            tooltip: 'RACE TIMER',
            child: Icon(
              Icons.timer,
              size: 42,
              color: Colors.white,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Constants.darkCyanColor,
          ),
          bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          StopwatchContent(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = HomeContent();
          break;
        case 1:
          _child = AccountContent();
          break;
        case 2:
          _child = GridContent();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
