import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../common_widgets/ensure_visible.dart';
import '../model/swimmer_account.dart';

class EditSwimmerNamePage extends StatefulWidget {
  const EditSwimmerNamePage({
    @required this.account,
  });
  final SwimmerAccount account;

  @override
  _EditSwimmerNamePageState createState() => _EditSwimmerNamePageState();
}

class _EditSwimmerNamePageState extends State<EditSwimmerNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  String _firstName;
  String _lastName;

  @override
  void initState() {
    super.initState();
    _firstName = widget.account.firstName;
    _lastName = widget.account.lastName;
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  String _firstNameValidator(String name) {
    final String str = name.trim();
    if (str.isEmpty) {
      return 'Please enter first name\n';
    }
    if (str.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    final str2 = str.replaceAll(RegExp(r"(_|[^\w\s\\'])+"), '');
    if (str == str2) {
      // doesn't contain special characters or emoji. Apostrophes are okay
      return null;
    }
    return 'Name may not contain special characters or emoji';
  }

  String _lastNameValidator(String name) {
    final str = name.trim();
    if (str.isEmpty) {
      return 'Please enter last name\n';
    }
    if (str.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    final str2 = str.replaceAll(RegExp(r"(_|[^\w\s\\'])+"), '');
    if (str == str2) {
      // doesn't contain special characters or emoji. Apostrophes are okay
      return null;
    }
    return 'Name may not contain special characters or emoji';
  }

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

  Widget _buildFirstNameButton(BuildContext context) {
    return EnsureVisibleWhenFocused(
      focusNode: _firstNameFocusNode,
      child: TextFormField(
        autofocus: true,
        initialValue: widget.account.firstName,
        keyboardType: TextInputType.text,
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          errorMaxLines: 2,
          errorStyle: Theme.of(context).textTheme.overline.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          labelText: 'First Name',
          contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
        ),
        focusNode: _firstNameFocusNode,
        validator: _firstNameValidator,
        onSaved: (str) => _firstName = str.trim(),
        onFieldSubmitted: (str) =>
            FocusScope.of(context).requestFocus(_lastNameFocusNode),
      ),
    );
  }

  Widget _buildLastNameButton(BuildContext context) {
    return EnsureVisibleWhenFocused(
      focusNode: _lastNameFocusNode,
      child: TextFormField(
        autofocus: false,
        initialValue: widget.account.lastName,
        keyboardType: TextInputType.text,
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          errorMaxLines: 2,
          errorStyle: Theme.of(context).textTheme.overline.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true,
          labelText: 'Last Name',
          contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
        ),
        focusNode: _lastNameFocusNode,
        validator: _lastNameValidator,
        onSaved: (str) => _lastName = str.trim(),
        onFieldSubmitted: (_) => _onFormSubmit(),
      ),
    );
  }

  void _onFormSubmit() {
    // hide keyboard if neccesary
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    final SwimmerAccount editedAccount = SwimmerAccount(
      id: widget.account.id,
      firstName: _firstName,
      lastName: _lastName,
      dateOfBirth: widget.account.dateOfBirth,
      gender: widget.account.gender,
    );
    Navigator.pop(context, editedAccount);
  }

  Widget _buildSaveButton(BuildContext context) {
    return PlatformButton(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
      color: Theme.of(context).colorScheme.primary,
      onPressed: _onFormSubmit,
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const StadiumBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        color: Theme.of(context).colorScheme.primaryVariant,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PlatformText(
            'Save Changes',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      leading: _buildBackButton(context),
      title: Text(
        'Edit Name',
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

  Widget _buildBody(BuildContext context) {
    final List<Widget> list = [];
    list.add(const SizedBox(height: 24.0));
    // first name
    list.add(_buildFirstNameButton(context));
    list.add(const SizedBox(height: 24.0));
    // Last name
    list.add(_buildLastNameButton(context));
    list.add(const SizedBox(height: 32.0));
    list.add(_buildSaveButton(context));

    // wrap in a form
    final form = Form(
      key: _formKey,
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: list,
          )),
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
