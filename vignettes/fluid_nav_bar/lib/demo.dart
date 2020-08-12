import 'package:flutter/material.dart';

import './content/account.dart';
import './content/grid.dart';
import './content/home.dart';
import './fluid_nav_bar.dart';
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
    super.initState();
    _child = HomeContent();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Scaffold(
//          backgroundColor: Constants.darkBackgroundColor, // Color(0xFF75B7E1),
          extendBody: false,
          extendBodyBehindAppBar: false,
          body: _child,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push<void>(_createRoute());
            },
            tooltip: 'RACE TIMER',
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primaryVariant,
            child: const Icon(
              Icons.timer,
              size: 42,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: FluidNavBar(onChange: _handleNavigationChange),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          StopwatchContent(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        final end = Offset.zero;
        const curve = Curves.ease;

        final tween =
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
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
