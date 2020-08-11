import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../model/app_format.dart';
import '../model/swimmer_account.dart';

class GenderDialog extends StatefulWidget {
  const GenderDialog({
    @required this.account,
  });
  final SwimmerAccount account;
  @override
  _GenderDialogState createState() => _GenderDialogState();
}

class _GenderDialogState extends State<GenderDialog> {
  final _formKey = GlobalKey<FormState>();
  Gender _gender;

  @override
  void initState() {
    super.initState();
    _gender = widget.account.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: PlatformAlertDialog(
        title: const Text('Gender'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              RadioListTile<Gender>(
                title: AppFormat.fixedText(
                  'Female',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
                value: Gender.female,
              ),
              RadioListTile<Gender>(
                title: AppFormat.fixedText(
                  'Male',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
                value: Gender.male,
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
            onPressed: () => Navigator.pop(context, _gender),
            child: PlatformText('OK'),
          ),
        ],
      ),
    );
  }
}
