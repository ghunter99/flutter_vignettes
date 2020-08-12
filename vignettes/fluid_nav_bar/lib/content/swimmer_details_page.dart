import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
import '../model/app_format.dart';
import '../model/swimmer_account.dart';
import '../styled_components/styled_swimmer_avatar.dart';
import 'edit_swimmer_page.dart';

class SwimmerDetailsPage extends HookWidget {
  const SwimmerDetailsPage(this.index);
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

  Widget _buildBackButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return PlatformButton(
      onPressed: () => Navigator.pop(context),
      padding: EdgeInsets.zero,
      color: Colors.transparent,
      child: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).colorScheme.onPrimary,
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
        shape: StadiumBorder(
            side: BorderSide(
          color: Theme.of(context).colorScheme.onPrimary,
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
            Icons.edit,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 18,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Edit',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
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
            color: Theme.of(context).colorScheme.onPrimary,
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

  Widget _buildAvatar(
    BuildContext context,
    SwimmerAccount account,
  ) {
    return StyledSwimmerAvatar(account: account, size: 100);
//    return CircleAvatar(
//      backgroundColor: Theme.of(context).colorScheme.primary,
//      foregroundColor: Colors.white,
//      radius: 48,
//      child: Text(
//        swimmers[index].initials,
//        style: const TextStyle(
//          fontSize: 42,
//          fontWeight: FontWeight.bold,
//        ),
//      ),
//    );
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
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: PlatformScaffold(
          iosContentPadding: true,
          iosContentBottomPadding: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 64),
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
                                      child: _buildAvatar(
                                        context,
                                        swimmers[index],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      swimmers[index].fullName,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontSize: 32,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                      height: 36,
                                      thickness: 1,
                                      color: Colors.grey),
                                  const Text(
                                    'Birthday',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      AppFormat.dMMMMyyyy(
                                          swimmers[index].dateOfBirth),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                      height: 36,
                                      thickness: 1,
                                      color: Colors.grey),
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 22),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      swimmers[index].genderString,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(flex: 1, child: SizedBox()),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
//              Positioned.fill(
//                child: Container(
//                  color: Colors.red,
//                ),
//              ),
              Positioned(
                top: 8,
                left: 0,
                child: _buildBackButton(context),
              ),
              Positioned(
                top: 8,
                right: 12,
                child: _buildEditButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
