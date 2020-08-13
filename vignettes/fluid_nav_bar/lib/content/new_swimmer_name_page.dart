import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../common_widgets/ensure_visible.dart';
import '../content/new_swimmer_birthdate_page.dart';
import '../model/swimmer_account.dart';

class NewSwimmerNamePage extends StatefulWidget {
  const NewSwimmerNamePage({
    @required this.account,
  });
  final SwimmerAccount account;

  @override
  _NewSwimmerNamePageState createState() => _NewSwimmerNamePageState();
}

class _NewSwimmerNamePageState extends State<NewSwimmerNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  String _firstName;
  String _lastName;
  String _birthdate;
  Gender _gender;

  @override
  void initState() {
    super.initState();
    _firstName = widget.account.firstName;
    _lastName = widget.account.lastName;
    _birthdate = widget.account.dateOfBirth;
    _gender = widget.account.gender;
  }

  @override
  void dispose() {
    // Clean up the focus nodes when the Form is disposed
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  String _firstNameValidator(String name) {
    // check length
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Please enter first name\n';
    }
    if (trimmedName.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    // check doesn't contain special characters or emoji
    // except for single quote, apostrophe or period characters
    final str1 =
        trimmedName.replaceAll("'", '').replaceAll('’', '').replaceAll('.', '');
    final str2 = trimmedName.replaceAll(RegExp(r'(_|[^\w\s])+'), '');
    if (str1 == str2) {
      return null;
    }
    return 'Name can not contain special characters or emoji';
  }

  String _lastNameValidator(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Please enter last name\n';
    }
    if (trimmedName.length > 35) {
      return 'Name can have at most 35 characters\n';
    }
    // check doesn't contain special characters or emoji
    // except for single quote, apostrophe or period characters
    final str1 =
        trimmedName.replaceAll("'", '').replaceAll('’', '').replaceAll('.', '');
    final str2 = trimmedName.replaceAll(RegExp(r'(_|[^\w\s])+'), '');
    if (str1 == str2) {
      return null;
    }
    return 'Name can not contain special characters or emoji';
  }

  Widget _buildBackButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.pop(context, null),
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
        initialValue: '',
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
        initialValue: '',
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

  Future<void> _onFormSubmit() async {
    // hide keyboard if neccesary
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    form.save();
    final SwimmerAccount account = SwimmerAccount(
      firstName: _firstName,
      lastName: _lastName,
      dateOfBirth: _birthdate,
      gender: _gender,
    );
    final newAccount = await Navigator.push<SwimmerAccount>(
      context,
      platformPageRoute(
        context: context,
        builder: (_) => NewSwimmerBirthdatePage(account: account),
      ),
    );
    if (newAccount != null) {
      setState(() {
        _birthdate = newAccount.dateOfBirth;
        _gender = newAccount.gender;
      });
    } else {
      Navigator.pop(context, null);
    }
  }

  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8, bottom: 0),
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
          'Next',
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
        'Name',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      trailingActions: <Widget>[
        _buildNextButton(context),
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

  Widget _buildBody(BuildContext context) {
    final List<Widget> list = [];
    list.add(const SizedBox(height: 32.0));
    // first name
    list.add(_buildFirstNameButton(context));
    list.add(const SizedBox(height: 32.0));
    // Last name
    list.add(_buildLastNameButton(context));
    // wrap in a form
    final form = Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        children: list,
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
