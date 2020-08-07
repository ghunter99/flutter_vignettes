import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../main.dart';
import '../model/date_string.dart';
import 'edit_swimmer_page.dart';

class ViewSwimmerPage extends HookWidget {
  const ViewSwimmerPage(this.index);
  final int index;

  bool _isApple(BuildContext context) {
    var result = false;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        result = true;
        break;
      default:
        break;
    }
    return result;
  }

  Widget _buildCloseButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      );
    }
    return PlatformButton(
      onPressed: () => Navigator.pop(context),
      color: Constants.darkBackgroundColor,
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
      ),
      child: const Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    Widget button = PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.transparent,
      onPressed: () {
        _openPage(context, (_) => EditSwimmerPage(index));
      },
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
            Icons.edit,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    final wrapWithStadiumBorder = _isApple(context);
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

  String formattedDate(String yyyyMMdd) {
    final dateString = DateString.yyyyMMdd(yyyyMMdd);
    return DateFormat('d MMMM yyyy', 'en').format(dateString.dateTime);
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
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final swimmers = useProvider(swimmerAccountListProvider.state);
    return Material(
      color: Constants.darkBackgroundColor,
      child: SafeArea(
        child: PlatformScaffold(
          iosContentPadding: true,
          iosContentBottomPadding: true,
          backgroundColor: Constants.darkBackgroundColor,
//      appBar: PlatformAppBar(
//        backgroundColor: Constants.darkBackgroundColor,
//        automaticallyImplyLeading: true,
//        trailingActions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.only(top: 16, right: 16),
//            child: _buildEditButton(context),
//          ),
//        ],
//        cupertino: (_, __) => CupertinoNavigationBarData(
//          border: const Border(),
//          transitionBetweenRoutes: false,
//          actionsForegroundColor: Colors.white,
//        ),
//        material: (_, __) => MaterialAppBarData(
//          elevation: 0,
//        ),
//      ),
          body: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildCloseButton(context),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: _buildEditButton(context),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Constants.darkPinkColor,
                              foregroundColor: Colors.white,
                              radius: 48,
                              child: Text(
                                swimmers[index].initials,
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            swimmers[index].fullName,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 32),
                          ),
                        ),
                        const Divider(
                            height: 36, thickness: 1, color: Colors.grey),
                        const Text(
                          'Birthday',
                          style: TextStyle(color: Colors.grey, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            formattedDate(swimmers[index].dateOfBirth),
                            style: const TextStyle(
                              color: Constants.darkPinkColor,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const Divider(
                            height: 36, thickness: 1, color: Colors.grey),
                        const Text(
                          'Gender',
                          style: TextStyle(color: Colors.grey, fontSize: 22),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            swimmers[index].genderString,
                            style: const TextStyle(
                              color: Constants.darkPinkColor,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
