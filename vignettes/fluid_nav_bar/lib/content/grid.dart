import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'settings_page.dart';

class GridContent extends StatelessWidget {
  Route _createRoute() {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
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

  //
  // Settings button
  //
  Widget _buildSettingsButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () {
          Navigator.of(context).push<void>(_createRoute());
        },
        icon: const Icon(
          Icons.settings,
        ),
      );
    }
    return PlatformButton(
      onPressed: () {
        Navigator.of(context).push<void>(_createRoute());
      },
      child: Icon(
        Icons.settings,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildSettingsButton(context),
            )
          ],
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: 0,
                    itemBuilder: (content, index) {
                      return Card(
//                        color: Constants.darkListTileBackgroundColor,
                        child: Theme(
                          data: ThemeData(
                            splashColor: isCupertino(context)
                                ? Colors.transparent
                                : null,
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
//                              backgroundColor: avatarBackgroundColor(index),
                              foregroundColor: Colors.white,
                              child: Text('GH'),
                            ),
                            title: const Text(
                              'Gary Hunter',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: const Text(
                              '29-10-1962',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
