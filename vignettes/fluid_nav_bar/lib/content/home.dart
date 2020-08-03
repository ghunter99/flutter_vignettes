import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../constants.dart';

class HomeContent extends HookWidget {
  @override
  Widget build(context) {
    final tabController = useTabController(
      initialLength: 2,
    );

    // do not show ripple on button tap for iOS or macOS
    var color = Colors.transparent;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        color = Constants.darkPinkColor;
        break;
      default:
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 44,
          color: Constants.darkBackgroundColor,
        ),
        Material(
          color: Constants.darkPinkColor,
          child: Container(
            height: 42,
            color: color,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TabBar(
              controller: tabController,
              labelColor: Constants.darkPinkColor,
              unselectedLabelColor: Constants.darkUnselectedTabLabelColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Constants.darkPinkColor,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
//            isScrollable: true,
              tabs: const <Widget>[
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'FAMILIES',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'SWIMMERS',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ListView.builder(
                        itemCount: 3,
                        itemBuilder: (content, index) {
                          final avatarColor = index % 2 == 0
                              ? const Color(0xFFf4a647)
                              : const Color(0xFF37598C);
                          return Card(
                            color: Constants.darkListTileBackgroundColor,
                            child: ListTile(
                              title: const Text(
                                'Susanna Hunter',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                'Phone: 0431 995 292',
                                style:
                                    TextStyle(color: Constants.darkPinkColor),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: avatarColor,
                                foregroundColor: Colors.white,
                                child: const Text('AH'),
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        itemCount: 12,
                        itemBuilder: (content, index) {
                          var avatarColor = Constants.darkCyanColor;
                          if (index % 4 == 1) {
                            avatarColor = const Color(0xFF37598C);
                          } else if (index % 4 == 2) {
                            avatarColor = const Color(0xFFf4a647);
                          } else if (index % 4 == 3) {
                            avatarColor = Constants.darkPinkColor;
                          }
                          return Card(
                            color: Constants.darkListTileBackgroundColor,
                            child: ListTile(
                              title: const Text(
                                'Beatrix Hunter',
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: const Text(
                                'Age: 11    Female',
                                style:
                                    TextStyle(color: Constants.darkPinkColor),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: avatarColor,
                                foregroundColor: Colors.white,
                                child: const Text('AH'),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
