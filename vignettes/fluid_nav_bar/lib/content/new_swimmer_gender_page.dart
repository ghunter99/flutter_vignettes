import 'package:fluid_nav_bar/styled_components/styled_trailing_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
import '../model/swimmer_account.dart';

class NewSwimmerGenderPage extends StatefulWidget {
  const NewSwimmerGenderPage({
    @required this.account,
  });
  final SwimmerAccount account;

  @override
  _NewSwimmerGenderPageState createState() => _NewSwimmerGenderPageState();
}

class _NewSwimmerGenderPageState extends State<NewSwimmerGenderPage> {
  final _formKey = GlobalKey<FormState>();

  Gender _gender;

  @override
  void initState() {
    super.initState();
    _gender = widget.account.gender;
  }

  void _onPressedBackButton() {
    final SwimmerAccount account = SwimmerAccount(
      firstName: widget.account.firstName,
      lastName: widget.account.lastName,
      dateOfBirth: widget.account.dateOfBirth,
      gender: _gender,
    );
    Navigator.pop(context, account);
  }

  Widget _buildBackButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        padding: EdgeInsets.zero,
        onPressed: _onPressedBackButton,
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return PlatformButton(
      onPressed: _onPressedBackButton,
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

  Future<void> _onFormSubmit() async {
    // hide keyboard if neccesary
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    swimmerAccountListProvider.read(context).add(
          firstName: widget.account.firstName,
          lastName: widget.account.lastName,
          dateOfBirth: widget.account.dateOfBirth,
          gender: _gender,
        );
    Navigator.pop(context, null);
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      leading: _buildBackButton(context),
      title: Text(
        'Gender',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      trailingActions: <Widget>[
        StyledTrailingActionButton('Save', _onFormSubmit),
      ],
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

  Widget _buildGenderChoiceButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        RadioListTile<Gender>(
          activeColor: Theme.of(context).colorScheme.primary,
          title: Text(
            'Female',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          groupValue: _gender,
          onChanged: (value) => setState(() => _gender = value),
          value: Gender.female,
        ),
        RadioListTile<Gender>(
          activeColor: Theme.of(context).colorScheme.primary,
          title: Text(
            'Male',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          groupValue: _gender,
          onChanged: (value) => setState(() => _gender = value),
          value: Gender.male,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final List<Widget> list = [];
    list.add(const SizedBox(height: 32.0));
    // first name
    //list.add(_buildFirstNameButton(context));
    list.add(const SizedBox(height: 32.0));
    // Last name
    //list.add(_buildLastNameButton(context));
    // wrap in a form
    final form = Form(
      key: _formKey,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          children: [
            _buildGenderChoiceButtons(context),
          ]),
    );
    return form;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: PlatformScaffold(
          iosContentPadding: true,
          iosContentBottomPadding: true,
          appBar: _buildAppBar(context),
          body: _buildBody(context),
        ),
      ),
    );
  }
}
