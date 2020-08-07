import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quiver/strings.dart' as qv;

import '../common_widgets/date_picker.dart';
import '../constants.dart';
import '../main.dart';
import '../model/date_string.dart';
import '../model/swimmer_account.dart';

class EditSwimmerPage extends HookWidget {
  EditSwimmerPage(this.index);
  final int index;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  Widget _buildBirthdayButton(SwimmerAccount swimmer) {
    DateString birthday = DateString.yyyyMMdd('19900101');
    if (swimmer.dateOfBirth != null) {
      birthday = DateString.yyyyMMdd(swimmer.dateOfBirth);
    }
    return DatePicker(
      labelText: 'Birthday',
      selectedDate: birthday.dateTime,
      onSelectedDate: (dateTime) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final swimmers = useProvider(swimmerAccountListProvider.state);
    final controller = useTextEditingController();
    //final update = useValueListenable(myTextControllerUpdates);
    useEffect(() {
      //controller.text = update;
      return null; // we don't need to have a special dispose logic
    }, []); // [update]);
    return Material(
      color: Constants.darkBackgroundColor,
      child: SafeArea(
        child: PlatformScaffold(
          iosContentPadding: true,
          iosContentBottomPadding: true,
          backgroundColor: Constants.darkBackgroundColor,
          body: Form(
            key: _formKey,
            child: ListView(
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
                          TextFormField(
                            autofocus: false,
                            autocorrect: false,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: false, //true,
                              labelText: 'First Name',
                              fillColor: Colors.orange,
                              focusColor: Colors.lightBlueAccent,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 12.0),
                              hintText: 'Required',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
//                          focusNode: _nameFocusNode,
                            controller: controller,
//                          onFieldSubmitted: (str) =>
//                              FocusScope.of(context).requestFocus(_servingSizeFocusNode),
                            validator: (value) {
                              if (qv.isBlank(value)) {
                                return 'Enter food name';
                              }
                              if (value.length > 35) {
                                return 'Name is too long';
                              }
                              return null;
                            },
                            //onSaved: (String value) => _newValues.name = value,
                          ),
                          const Divider(
                              height: 36, thickness: 1, color: Colors.grey),
                          TextFormField(
                            autofocus: false,
                            autocorrect: false,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 22),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            showCursor: true,
                            cursorColor: Constants.darkPinkColor,
                            cursorWidth: 3,
                            maxLengthEnforced: true,
                            maxLength: 35,
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              filled: false,
                              labelText: 'Last Name',
                              fillColor: Colors.orange,
                              focusColor: Colors.lightBlueAccent,
//                              contentPadding:
//                                  EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 12.0),
                              hintText: 'Required',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
//                          focusNode: _nameFocusNode,
                            controller: controller,
//                          onFieldSubmitted: (str) =>
//                              FocusScope.of(context).requestFocus(_servingSizeFocusNode),
                            validator: (value) {
                              if (qv.isBlank(value)) {
                                return 'Enter food name';
                              }
                              if (value.length > 35) {
                                return 'Name is too long';
                              }
                              return null;
                            },
                            //onSaved: (String value) => _newValues.name = value,
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
                          _buildBirthdayButton(swimmers[index]),
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
      ),
    );
  }
}
