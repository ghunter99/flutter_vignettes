import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../constants.dart';

enum _State {
  timerInitial,
  timerRunPause,
  timerRunInProgress,
  timerRunComlate,
}

class StopwatchContent extends StatefulWidget {
  @override
  _StopwatchContentState createState() => _StopwatchContentState();
}

class _StopwatchContentState extends State<StopwatchContent> {
  _State timerState = _State.timerInitial;

  @override
  void initState() {
    super.initState();
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
              onPressed: () => Navigator.pop(context),
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
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 24),
                PlatformButton(
                  padding: EdgeInsets.zero,
                  color: Constants.darkPinkColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PlatformText(
                        'Event',
                        style: TextStyle(color: Colors.white),
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
                  padding: EdgeInsets.zero,
                  color: Constants.darkPinkColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PlatformText(
                        'Lane 1',
                        style: TextStyle(color: Colors.white),
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
                  padding: EdgeInsets.zero,
                  color: Constants.darkPinkColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      PlatformText(
                        'Mab Murphy-Midgely',
                        style: TextStyle(color: Colors.white),
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
                SizedBox(height: 48),
                PlatformText(
                  '00:00:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 48),
                PlatformButton(
                  color: Constants.darkCyanColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      PlatformText(
                        'START',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                  materialFlat: (_, __) => MaterialFlatButtonData(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Constants.darkCyanColor)),
                  ),
                  cupertino: (_, __) => CupertinoButtonData(
                    color: Constants.darkCyanColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
