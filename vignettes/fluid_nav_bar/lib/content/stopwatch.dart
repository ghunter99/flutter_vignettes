import 'dart:math';

import 'package:fluid_nav_bar/content/choose_swimmer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../app_constants.dart';
import '../content/choose_lane_page.dart';
import '../main.dart';
import '../model/swimmer_account.dart';
import 'choose_event_page.dart';
import 'liquid_painter.dart';

enum _State {
  timerInitial,
  timerRunPause,
  timerRunInProgress,
  timerRunComplete,
}

final timeProvider = Provider((_) => '00:00:00');

class StopwatchContent extends StatefulWidget {
  final isOpen = true;
  final requiredPoints = 100;
  final earnedPoints = 68;
  @override
  _StopwatchContentState createState() => _StopwatchContentState();
}

class _StopwatchContentState extends State<StopwatchContent>
    with TickerProviderStateMixin {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
//    onChange: (value) => print('onChange $value'),
//    onChangeSecond: (value) => print('onChangeSecond $value'),
//    onChangeMinute: (value) => print('onChangeMinute $value'),
      );
  _State _timerState = _State.timerInitial;
  bool _wasOpen = false;
  Animation<double> _fillTween;
  AnimationController _liquidSimController;

  //Create 2 simulations, that will be passed to the LiquidPainter to be drawn.
  final LiquidSimulation _liquidSim1 = LiquidSimulation();
  final LiquidSimulation _liquidSim2 = LiquidSimulation();

  double _screenHeight;

  SwimEvent _swimEvent = SwimEvent.freestyle25m;
  int _swimLane = AppConstants.firstSwimLane;
  SwimmerAccount _swimmerAccount;

  @override
  void initState() {
    super.initState();
    //Create a controller to drive the "fill" animations
    _liquidSimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _liquidSimController.addListener(_rebuildIfOpen);
    //create tween to raise the fill level of the card
    _fillTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _liquidSimController,
          curve: const Interval(.12, .45, curve: Curves.easeOut)),
//          curve: Interval(.12, .45, curve: Curves.easeOut)),
    );
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    _liquidSimController.dispose();
    super.dispose();
  }

  void _rebuildIfOpen() {
    if (widget.isOpen) {
      setState(() {});
    }
  }

  Widget _buildCancelButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
        ),
      );
    }
    return PlatformButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pop(context);
      },
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      automaticallyImplyLeading: false,
      trailingActions: <Widget>[
        _buildCancelButton(context),
      ],
      cupertino: (_, __) => CupertinoNavigationBarData(
        padding: const EdgeInsetsDirectional.only(start: 0, end: 0),
        backgroundColor: Colors.transparent,
        border: const Border(),
        transitionBetweenRoutes: false,
      ),
      material: (_, __) => MaterialAppBarData(
        centerTitle: true,
        elevation: 0,
      ),
    );
  }

  Route<SwimEvent> _createChooseEventPageRoute() {
    return PageRouteBuilder<SwimEvent>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ChooseEventPage(_swimEvent),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        final end = Offset.zero;
        final curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildEventButton(BuildContext context) {
    return PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        final event = await Navigator.of(context)
            .push<SwimEvent>(_createChooseEventPageRoute());
        if (event != null && event != _swimEvent) {
          setState(() {
            _swimEvent = event;
          });
        }
      },
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const StadiumBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _swimEvent.toString(),
            style: Theme.of(context).textTheme.headline3.copyWith(
                  color: Colors.white,
                ),
          ),
          const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Route<int> _createChooseLanePageRoute() {
    return PageRouteBuilder<int>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ChooseLanePage(_swimLane),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        final end = Offset.zero;
        final curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildLaneButton(BuildContext context) {
    return PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        final lane =
            await Navigator.of(context).push<int>(_createChooseLanePageRoute());
        if (lane != null && lane != _swimLane) {
          setState(() {
            _swimLane = lane;
          });
        }
      },
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const StadiumBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Lane $_swimLane',
            style: Theme.of(context).textTheme.headline3.copyWith(
                  color: Colors.white,
                ),
          ),
          const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Route<SwimmerAccount> _createChooseSwimmerPageRoute() {
    return PageRouteBuilder<SwimmerAccount>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          ChooseSwimmerPage(_swimmerAccount),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        final end = Offset.zero;
        final curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildSwimmerName(BuildContext context) {
    return PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        final swimmer = await Navigator.of(context)
            .push<SwimmerAccount>(_createChooseSwimmerPageRoute());
        if (swimmer != null && swimmer.id != _swimmerAccount.id) {
          setState(() {
            _swimmerAccount = swimmer;
          });
        }
      },
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const StadiumBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          PlatformText(
            _swimmerAccount.fullName,
            style: Theme.of(context).textTheme.headline3.copyWith(
                  color: Colors.white,
                ),
          ),
          const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Stack _buildLiquidBackground(double _maxFillLevel, double fillLevel) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Transform.translate(
          offset: Offset(
              0,
              _screenHeight * 1.2 -
                  _screenHeight * _fillTween.value * _maxFillLevel * 1.2),
          child: CustomPaint(
            painter: LiquidPainter(fillLevel, _liquidSim1, _liquidSim2,
                waveHeight: 100),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final swimmers = useProvider(swimmerAccountListProvider.state);
    if (_swimmerAccount == null) {
      _swimmerAccount = swimmers[0];
    }

    _screenHeight ??= MediaQuery.of(context).size.height;

    //If our open state has changed...
    if (widget.isOpen != _wasOpen) {
      //Kickoff the fill animations if we're opening up
      if (widget.isOpen) {
        //Start both of the liquid simulations, they will initialize to random values
        _liquidSim1.start(_liquidSimController, flipY: true);
        _liquidSim2.start(_liquidSimController, flipY: false);
      }
      _wasOpen = widget.isOpen;
    }

    //Determine current fill level, based on _fillTween
    final double _maxFillLevel =
        min(1, widget.earnedPoints / widget.requiredPoints);
    final double fillLevel = _maxFillLevel; //_maxFillLevel * _fillTween.value;

    return Material(
      color: Colors.transparent,
      child: PlatformScaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        iosContentPadding: true,
        appBar: _buildAppBar(context),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AnimatedOpacity(
              opacity: widget.isOpen ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: _buildLiquidBackground(_maxFillLevel, fillLevel),
            ),

            // Stopwatch content
            Container(
              padding: const EdgeInsets.only(
                  left: 32, right: 32, top: 24, bottom: 48),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        _buildEventButton(context),
                        const SizedBox(height: 24),
                        _buildLaneButton(context),
                        const SizedBox(height: 24),
                        _buildSwimmerName(context),
                      ],
                    ),
                    StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data;
                        final displayTime =
                            StopWatchTimer.getDisplayTime(value);
                        return Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 56,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
//                        Padding(
//                          padding: const EdgeInsets.all(8),
//                          child: Text(
//                            value.toString(),
//                            style: TextStyle(
//                                fontSize: 16,
//                                fontFamily: 'Helvetica',
//                                fontWeight: FontWeight.w400),
//                          ),
//                        ),
                          ],
                        );
                      },
                    ),
//                PlatformText(
//                  '00:00:00',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 64,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
                    if (_timerState == _State.timerInitial)
                      PlatformButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                            //Run the animation controller, kicking off all tweens
                            _liquidSimController.forward(from: 0);
                            _timerState = _State.timerRunInProgress;
                          });
                        },
                        materialFlat: (_, __) => MaterialFlatButtonData(
                          shape: const StadiumBorder(),
                        ),
                        cupertino: (_, __) => CupertinoButtonData(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PlatformText(
                              'START',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (_timerState == _State.timerRunInProgress)
                      PlatformButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                          //Run the animation controller in reverse, kicking off all tweens
                          _liquidSimController.reverse();
                          setState(() {
                            _timerState = _State.timerRunPause;
                          });
                        },
                        materialFlat: (_, __) => MaterialFlatButtonData(
                          shape: const StadiumBorder(),
                        ),
                        cupertino: (_, __) => CupertinoButtonData(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            PlatformText(
                              'STOP',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    if (_timerState == _State.timerRunPause)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          PlatformButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                            color: Colors.lightBlue,
                            onPressed: () {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                              setState(() {
                                _timerState = _State.timerInitial;
                              });
                            },
                            materialFlat: (_, __) => MaterialFlatButtonData(
                              shape: const StadiumBorder(),
                            ),
                            cupertino: (_, __) => CupertinoButtonData(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                          PlatformButton(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                              setState(() {
                                _timerState = _State.timerRunComplete;
                                Navigator.pop(context);
                              });
                            },
                            materialFlat: (_, __) => MaterialFlatButtonData(
                              shape: const StadiumBorder(),
                            ),
                            cupertino: (_, __) => CupertinoButtonData(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: PlatformText(
                              'FINISH',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
