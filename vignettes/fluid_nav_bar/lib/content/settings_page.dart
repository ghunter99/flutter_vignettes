import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../data/app_options.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
//      backgroundColor: Theme.of(context).canvasColor,
      automaticallyImplyLeading: false,
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      trailingActions: <Widget>[
        PlatformButton(
          padding: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.background,
          onPressed: () {
            Navigator.pop(context);
          },
//          color: Theme.of(context).canvasColor,
          child: Text(
            'Close',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        )
      ],
      cupertino: (_, __) => CupertinoNavigationBarData(
        backgroundColor: Colors.transparent,
        border: const Border(),
        transitionBetweenRoutes: false,
      ),
      material: (_, __) => MaterialAppBarData(
        elevation: 0,
      ),
    );
  }

  void _showThemeModalPopup() {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (context) => CupertinoActionSheet(
              title: const Text('Theme'),
              actions: [
                CupertinoActionSheetAction(
                  onPressed: () {
                    AppOptions.update(
                      context,
                      AppOptions.of(context)
                          .copyWith(themeMode: ThemeMode.light),
                    );
                    Navigator.pop(context, true);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.check,
                        color: Colors.transparent,
                      ),
                      Text(
                        'Light',
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.check,
                      )
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    AppOptions.update(
                      context,
                      AppOptions.of(context)
                          .copyWith(themeMode: ThemeMode.dark),
                    );
                    Navigator.pop(context, true);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.check,
                        color: Colors.transparent,
                      ),
                      Text(
                        'Dark',
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.check,
                      )
                    ],
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    AppOptions.update(
                      context,
                      AppOptions.of(context)
                          .copyWith(themeMode: ThemeMode.system),
                    );
                    Navigator.pop(context, true);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.check,
                        color: Colors.transparent,
                      ),
                      Text(
                        'System default',
                        textAlign: TextAlign.left,
                      ),
                      Icon(
                        Icons.check,
                      )
                    ],
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: PlatformScaffold(
          appBar: _buildAppBar(context),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'PREFERENCES',
                        style: Theme.of(context).textTheme.overline.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: InkWell(
                              splashColor: isCupertino(context)
                                  ? Colors.transparent
                                  : null,
                              onTap: _showThemeModalPopup,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Theme',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                        ),
                                        Text(
                                          'System default',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_right,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
//                        Padding(
//                          padding: const EdgeInsets.symmetric(horizontal: 8),
//                          child: Divider(),
//                        )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
