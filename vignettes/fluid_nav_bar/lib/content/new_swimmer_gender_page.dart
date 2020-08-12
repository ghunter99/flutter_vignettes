import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../main.dart';
import '../model/app_format.dart';
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

  Widget _buildBackButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          final SwimmerAccount account = SwimmerAccount(
            firstName: widget.account.firstName,
            lastName: widget.account.lastName,
            dateOfBirth: widget.account.dateOfBirth,
            gender: _gender,
          );
          Navigator.pop(context, account);
        },
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

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      child: PlatformButton(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        color: Theme.of(context).colorScheme.primaryVariant,
        onPressed: _onFormSubmit,
        materialFlat: (_, __) => MaterialFlatButtonData(
          shape: const StadiumBorder(),
        ),
        cupertino: (_, __) => CupertinoButtonData(
          color: Theme.of(context).colorScheme.primaryVariant,
          borderRadius: BorderRadius.circular(50),
        ),
        child: PlatformText(
          'Save',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
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
        _buildSaveButton(context),
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
          title: AppFormat.fixedText(
            'Female',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          groupValue: _gender,
          onChanged: (value) => setState(() => _gender = value),
          value: Gender.female,
        ),
        RadioListTile<Gender>(
          activeColor: Theme.of(context).colorScheme.primary,
          title: AppFormat.fixedText(
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
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: _buildGenderChoiceButtons(context),
      ),
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
