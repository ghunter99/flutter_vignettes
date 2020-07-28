import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../constants.dart';

enum _State {
  timerInitial,
  timerRunPause,
  timerRunInProgress,
  timerRunComplete,
}

final timeProvider = Provider((_) => '00:00:00');

class StopwatchContent extends StatefulWidget {
  @override
  _StopwatchContentState createState() => _StopwatchContentState();
}

class _StopwatchContentState extends State<StopwatchContent> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
//    onChange: (value) => print('onChange $value'),
//    onChangeSecond: (value) => print('onChangeSecond $value'),
//    onChangeMinute: (value) => print('onChangeMinute $value'),
      );

  _State _timerState = _State.timerInitial;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    await _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: PlatformScaffold(
        backgroundColor: Constants.darkBackgroundColor,
        appBar: PlatformAppBar(
          backgroundColor: Constants.darkBackgroundColor,
          automaticallyImplyLeading: false,
          trailingActions: <Widget>[
            PlatformButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                Navigator.pop(context);
              },
              color: Constants.darkBackgroundColor,
              child: Text(
                'Close',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
          cupertino: (_, __) => CupertinoNavigationBarData(
            border: Border(),
            transitionBetweenRoutes: false,
          ),
          material: (_, __) => MaterialAppBarData(
            elevation: 0,
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 32,
            right: 32,
            top: 24,
            bottom: 48,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    PlatformButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                      color: Constants.darkPinkColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          PlatformText(
                            'Event',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                      onPressed: () {},
                      materialFlat: (_, __) => MaterialFlatButtonData(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Constants.darkPinkColor)),
                      ),
                      cupertino: (_, __) => CupertinoButtonData(
                        color: Constants.darkPinkColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(height: 24),
                    PlatformButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                      color: Constants.darkPinkColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          PlatformText(
                            'Lane 1',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                      onPressed: () {},
                      materialFlat: (_, __) => MaterialFlatButtonData(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Constants.darkPinkColor)),
                      ),
                      cupertino: (_, __) => CupertinoButtonData(
                        color: Constants.darkPinkColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(height: 24),
                    PlatformButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                      color: Constants.darkPinkColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          PlatformText(
                            'Mab Murphy-Midgely',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                      onPressed: () {},
                      materialFlat: (_, __) => MaterialFlatButtonData(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Constants.darkPinkColor)),
                      ),
                      cupertino: (_, __) => CupertinoButtonData(
                        color: Constants.darkPinkColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value);
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            displayTime,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 72,
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
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PlatformText(
                          'START',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                      setState(() {
                        _timerState = _State.timerRunInProgress;
                      });
                    },
                    materialFlat: (_, __) => MaterialFlatButtonData(
                      shape: const StadiumBorder(),
//                    RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(50),
//                        side: BorderSide(color: Constants.darkCyanColor)),
                    ),
                    cupertino: (_, __) => CupertinoButtonData(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                if (_timerState == _State.timerRunInProgress)
                  PlatformButton(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        PlatformText(
                          'STOP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      setState(() {
                        _timerState = _State.timerRunPause;
                      });
                    },
                    materialFlat: (_, __) => MaterialFlatButtonData(
                      shape: const StadiumBorder(),
//                    RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(50),
//                        side: BorderSide(color: Constants.darkCyanColor)),
                    ),
                    cupertino: (_, __) => CupertinoButtonData(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                if (_timerState == _State.timerRunPause)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PlatformButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        color: Colors.lightBlue,
                        child: Icon(
                          Icons.refresh,
                          color: Colors.white,
                          size: 42,
                        ),
                        onPressed: () {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
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
                      ),
                      PlatformButton(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        color: Colors.red,
                        child: PlatformText(
                          'FINISH',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
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
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
