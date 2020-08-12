import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../model/app_format.dart';
import '../model/date_string.dart';
import '../model/swimmer_account.dart';
import 'new_swimmer_gender_page.dart';

class NewSwimmerBirthdatePage extends StatefulWidget {
  const NewSwimmerBirthdatePage({
    @required this.account,
  });
  final SwimmerAccount account;

  @override
  _NewSwimmerBirthdatePageState createState() =>
      _NewSwimmerBirthdatePageState();
}

class _NewSwimmerBirthdatePageState extends State<NewSwimmerBirthdatePage> {
  final _formKey = GlobalKey<FormState>();

  String _birthdate;
  Gender _gender;

  @override
  void initState() {
    super.initState();
    _birthdate = widget.account.dateOfBirth;
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
            dateOfBirth: _birthdate,
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
    final SwimmerAccount account = SwimmerAccount(
      firstName: widget.account.firstName,
      lastName: widget.account.lastName,
      dateOfBirth: _birthdate,
      gender: _gender,
    );
    final newAccount = await Navigator.push<SwimmerAccount>(
      context,
      platformPageRoute(
        context: context,
        builder: (_) => NewSwimmerGenderPage(account: account),
      ),
    );
    if (newAccount != null) {
      setState(() {
        _gender = newAccount.gender;
      });
    } else {
      Navigator.pop(context, null);
    }
  }

  Widget _buildNextButton(BuildContext context) {
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
        'Birthdate',
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

  Widget _buildBirthdateButton(BuildContext context) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () async {
        final selectedDate = DateString.yyyyMMdd(_birthdate);
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate.dateTime,
          firstDate: DateTime(1900),
          lastDate: DateTime(DateTime.now().year - 1),
        );
        if (pickedDate != null) {
          setState(() {
            _birthdate = DateString(pickedDate).yyyyMMdd;
          });
        }
      },
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
                  AppFormat.dMMMMyyyy(_birthdate),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final List<Widget> list = [];
    list.add(const SizedBox(height: 32.0));
    // birthdate
    list.add(_buildBirthdateButton(context));
    list.add(const SizedBox(height: 32.0));
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
