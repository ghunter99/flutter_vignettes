import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './content/account.dart';
import './content/grid.dart';
import './content/home.dart';
import './fluid_nav_bar.dart';
import 'content/account.dart';
import 'content/stopwatch.dart';
import 'main.dart';
import 'model/swimmer_account.dart';

class FluidNavBarDemo extends HookWidget {
  Route _createRoute(List<SwimmerAccount> swimmerList) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => StopwatchContent(
        swimmerList: swimmerList,
      ),
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

  @override
  Widget build(context) {
    final child = useState(HomeContent() as Widget);
    final swimmerList = useProvider(swimmerAccountListProvider.state);

    return Material(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Scaffold(
//          backgroundColor: Constants.darkBackgroundColor, // Color(0xFF75B7E1),
          extendBody: false,
          extendBodyBehindAppBar: false,
          body: child.value,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push<void>(_createRoute(swimmerList));
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
          bottomNavigationBar: FluidNavBar(
            onChange: (index) {
              switch (index) {
                case 0:
                  child.value = HomeContent();
                  break;
                case 1:
                  child.value = AccountContent();
                  break;
                case 2:
                  child.value = GridContent();
                  break;
              }
              child.value = AnimatedSwitcher(
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
                child: child.value,
              );
            },
          ),
        ),
      ),
    );
  }
}
