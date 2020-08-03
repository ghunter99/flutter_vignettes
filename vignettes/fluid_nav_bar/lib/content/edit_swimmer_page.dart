import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../main.dart';
import '../model/date_string.dart';

class EditSwimmerPage extends HookWidget {
  const EditSwimmerPage(this.index);
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

  Widget _buildCancelButton(BuildContext context) {
    return PlatformButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Constants.darkBackgroundColor,
      materialFlat: (_, __) => MaterialFlatButtonData(
        padding: EdgeInsets.zero,
        splashColor: Constants.selectedBackgroundColor,
        shape: const CircleBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
      ),
      child: const Text(
        'Cancel',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return PlatformButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Constants.darkBackgroundColor,
      materialFlat: (_, __) => MaterialFlatButtonData(
        padding: EdgeInsets.zero,
        splashColor: Constants.selectedBackgroundColor,
        shape: const CircleBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
      ),
      child: const Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  String formattedDate(String yyyyMMdd) {
    final dateString = DateString.yyyyMMdd(yyyyMMdd);
    return DateFormat('d MMMM yyyy', 'en').format(dateString.dateTime);
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
          body: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildCancelButton(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildSaveButton(context),
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
                                style: TextStyle(
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
