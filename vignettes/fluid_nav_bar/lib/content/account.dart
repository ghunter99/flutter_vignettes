import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants.dart';
import '../main.dart';
import 'view_swimmer_page.dart';

class AccountContent extends HookWidget {
  Widget _buildAddSwimmerButton(BuildContext context) {
    Widget button = PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.transparent,
      onPressed: () {},
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 1.5,
        )),
        splashColor: Constants.selectedBackgroundColor,
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Swimmer',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    final wrapWithStadiumBorder = isCupertino(context);
    if (wrapWithStadiumBorder) {
      button = Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            width: 1.5,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: button,
      );
    }
    return button;
  }

  Color avatarBackgroundColor(int index) {
    var color = Constants.darkCyanColor;
    if (index % 4 == 1) {
      color = const Color(0xFF37598C);
    } else if (index % 4 == 2) {
      color = const Color(0xFFf4a647);
    } else if (index % 4 == 3) {
      color = Constants.darkPinkColor;
    }
    return color;
  }

  void _openPage(
    BuildContext context,
    WidgetBuilder pageToDisplayBuilder,
  ) {
    Navigator.push<void>(
      context,
      platformPageRoute(
        context: context,
        builder: pageToDisplayBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final swimmers = useProvider(swimmerAccountListProvider.state);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildAddSwimmerButton(context),
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
                    itemCount: swimmers.length,
                    itemBuilder: (content, index) {
                      return Card(
                        color: Constants.darkListTileBackgroundColor,
                        child: Theme(
                          data: ThemeData(
                            splashColor: isCupertino(context)
                                ? Colors.transparent
                                : null,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: avatarBackgroundColor(index),
                              foregroundColor: Colors.white,
                              child: Text(swimmers[index].initials),
                            ),
                            title: Text(
                              swimmers[index].fullName,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              swimmers[index].dateOfBirth,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () => _openPage(
                              context,
                              (_) => ViewSwimmerPage(index),
                            ),
                          ),
                        ),
                      );
                    },
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
