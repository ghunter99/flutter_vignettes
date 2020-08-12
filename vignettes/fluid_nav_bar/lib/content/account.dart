import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants.dart';
import '../main.dart';
import '../model/app_format.dart';
import '../model/date_string.dart';
import '../model/swimmer_account.dart';
import '../styled_components/styled_swimmer_avatar.dart';
import 'view_swimmer_page.dart';

class AccountContent extends HookWidget {
  Widget _buildAddSwimmerButton(BuildContext context) {
    Widget button = PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      color: Colors.transparent,
      onPressed: () {},
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
            Icons.add,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            'Swimmer',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
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

  Widget _buildAvatar(BuildContext context, SwimmerAccount account) {
    return StyledSwimmerAvatar(account: account, size: 60);
//    return CircleAvatar(
//      backgroundColor: avatarBackgroundColor(index),
//      foregroundColor: Colors.white,
//      child: Text(swimmer.initials),
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
              padding: const EdgeInsets.all(16),
              child: _buildAddSwimmerButton(context),
            )
          ],
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: swimmers.length,
                  itemBuilder: (content, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      //color: Constants.darkListTileBackgroundColor,
                      child: Theme(
                        data: ThemeData(
                          splashColor:
                              isCupertino(context) ? Colors.transparent : null,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: _buildAvatar(
                            context,
                            swimmers[index],
                          ),
                          title: Text(
                            swimmers[index].fullName,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
//                            style: TextStyle(
//                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          subtitle: Text(
                            'Age:  ${DateString.yyyyMMdd(swimmers[index].dateOfBirth).ageInYears}\n'
                            'Birthday:  ${AppFormat.dMMMMyyyy(swimmers[index].dateOfBirth)}\n'
                            'Gender:  ${swimmers[index].genderString}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
//                            style: TextStyle(
//                                color: Theme.of(context).colorScheme.primary),
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
      ],
    );
  }
}
