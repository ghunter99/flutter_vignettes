import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../model/app_format.dart';

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({
    @required this.themeMode,
  });
  final ThemeMode themeMode;
  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  final _formKey = GlobalKey<FormState>();
  ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.themeMode;
  }

  void _onChanged(ThemeMode value) {
    if (_themeMode != value) {
      setState(() {
        _themeMode = value;
        // uncomment this code if we want to return directly
        // tappimg a radio button
//        WidgetsBinding.instance.addPostFrameCallback((_) async {
//          Future<void>.delayed(const Duration(milliseconds: 200), () {
//            Navigator.pop(context, _themeMode);
//          });
//        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: PlatformAlertDialog(
        title: const Text('Theme'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              RadioListTile<ThemeMode>(
                title: AppFormat.fixedText(
                  'Light',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                groupValue: _themeMode,
                onChanged: _onChanged,
                value: ThemeMode.light,
              ),
              RadioListTile<ThemeMode>(
                title: AppFormat.fixedText(
                  'Dark',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                groupValue: _themeMode,
                onChanged: _onChanged,
                value: ThemeMode.dark,
              ),
              RadioListTile<ThemeMode>(
                title: AppFormat.fixedText(
                  'System',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                groupValue: _themeMode,
                onChanged: _onChanged,
                value: ThemeMode.system,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          PlatformDialogAction(
            android: (_) => MaterialDialogActionData(),
            ios: (_) => CupertinoDialogActionData(
                textStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
            onPressed: () => Navigator.pop(context, null),
            child: PlatformText('Cancel'),
          ),
          PlatformDialogAction(
            android: (_) => MaterialDialogActionData(),
            ios: (_) => CupertinoDialogActionData(
                textStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    )),
            onPressed: () => Navigator.pop(context, _themeMode),
            child: PlatformText('OK'),
          ),
        ],
      ),
    );
  }
}
