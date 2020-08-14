import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../data/app_options.dart';
import 'theme_dialog.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _buildCancelButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return PlatformButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pop(context);
      },
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Settings',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      trailingActions: <Widget>[
        _buildCancelButton(context),
      ],
      cupertino: (_, __) => CupertinoNavigationBarData(
        padding: const EdgeInsetsDirectional.only(start: 0, end: 0),
        backgroundColor: Colors.transparent,
        border: const Border(),
        transitionBetweenRoutes: false,
      ),
      material: (_, __) => MaterialAppBarData(
        centerTitle: true,
        elevation: 0,
      ),
    );
  }

  Future<ThemeMode> _showThemeDialog(
    BuildContext context,
    ThemeMode themeMode,
  ) async {
    return showPlatformDialog(
      context: context,
      builder: (_) => ThemeDialog(themeMode: themeMode),
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

  String _themeModeToString(ThemeMode mode) {
    String result;
    switch (mode) {
      case ThemeMode.light:
        result = 'Light';
        break;
      case ThemeMode.dark:
        result = 'Dark';
        break;
      case ThemeMode.system:
        result = 'System default';
        break;
    }
    return result;
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
//                              onTap: _showThemeModalPopup,
                              onTap: () async {
                                final themeMode = await _showThemeDialog(
                                    context, AppOptions.of(context).themeMode);
                                if (themeMode != null &&
                                    themeMode !=
                                        AppOptions.of(context).themeMode) {
                                  AppOptions.update(
                                    context,
                                    AppOptions.of(context)
                                        .copyWith(themeMode: themeMode),
                                  );
                                }
                              },
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
                                          _themeModeToString(
                                              AppOptions.of(context).themeMode),
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
