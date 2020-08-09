import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiver/strings.dart' as qv;

import '../common_widgets/date_picker.dart';
import '../constants.dart';
import '../main.dart';
import '../model/app_format.dart';
import '../model/date_string.dart';
import '../model/swimmer_account.dart';

class EditSwimmerPage extends HookWidget {
  EditSwimmerPage(this.index);

  final int index;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildBackButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        padding: EdgeInsets.zero,
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
      cupertino: (_, __) => CupertinoButtonData(
        color: Colors.transparent,
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      leading: _buildBackButton(context),
      title: Text(
        'Edit',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      cupertino: (_, __) => CupertinoNavigationBarData(
        padding: const EdgeInsetsDirectional.only(start: 0),
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

  Widget _buildAvatarButton(BuildContext context) {
    return PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {},
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const CircleBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        borderRadius: BorderRadius.circular(100),
      ),
      child: const Icon(
        Icons.camera_alt,
        color: Colors.white,
        size: 32,
      ),
    );
  }

  Widget _buildFirstNameButton(
    BuildContext context,
    SwimmerAccount swimmer,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12, right: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First Name',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  swimmer.firstName,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.primary,
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
    );
  }

  Widget _buildLastNameButton(
    BuildContext context,
    SwimmerAccount swimmer,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12, right: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Name',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  swimmer.lastName,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.primary,
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
    );
  }

  Widget _buildBirthdateButton(
    BuildContext context,
    SwimmerAccount swimmer,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12, right: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Birthdate',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppFormat.dMMMMyyyy(swimmer.dateOfBirth),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.primary,
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
    );
  }

  Widget _buildGenderButton(
    BuildContext context,
    SwimmerAccount swimmer,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12, right: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  swimmer.genderString,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.primary,
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
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: PlatformScaffold(
          appBar: _buildAppBar(context),
          body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _buildAvatarButton(context),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Column(
                          children: [
                            _buildFirstNameButton(context, swimmers[index]),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            _buildLastNameButton(context, swimmers[index]),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            _buildBirthdateButton(context, swimmers[index]),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            _buildGenderButton(context, swimmers[index]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 200),
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
                          filled: false,
                          //true,
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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
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
                          AppFormat.dMMMMyyyy(swimmers[index].dateOfBirth),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
