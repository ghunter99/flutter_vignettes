import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';

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
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          PlatformText(
            'Swimmer',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    var wrapWithStadiumBorder = false;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        wrapWithStadiumBorder = true;
        break;
      default:
        break;
    }
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
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: swimmers.length,
                    itemBuilder: (content, index) {
                      return Card(
                        color: Colors.red,
                        child: ListTile(
                          title: Text(swimmers[index].firstName),
                          subtitle: Text(swimmers[index].dateOfBirth),
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
