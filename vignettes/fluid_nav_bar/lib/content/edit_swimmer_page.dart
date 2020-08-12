import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../content/gender_dialog.dart';
import '../main.dart';
import '../model/app_format.dart';
import '../model/date_string.dart';
import '../model/swimmer_account.dart';
import '../styled_components/styled_swimmer_avatar.dart';
import 'edit_swimmer_name_page.dart';

class EditSwimmerPage extends HookWidget {
  EditSwimmerPage(this.index);

  final int index;

  Future<void> _openEditSwimmerNamePage(
    BuildContext context,
    SwimmerAccount account,
  ) async {
    final editedAccount = await Navigator.push<SwimmerAccount>(
      context,
      platformPageRoute(
        context: context,
        builder: (_) => EditSwimmerNamePage(account: account),
      ),
    );
    if (editedAccount != null &&
        (account.firstName.compareTo(editedAccount.firstName) != 0 ||
            account.lastName.compareTo(editedAccount.lastName) != 0)) {
      swimmerAccountListProvider.read(context).edit(
            id: account.id,
            firstName: editedAccount.firstName,
            lastName: editedAccount.lastName,
            dateOfBirth: account.dateOfBirth,
            gender: account.gender,
          );
    }
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

  Widget _buildAvatarButton(
    BuildContext context,
    SwimmerAccount account,
  ) {
    return PlatformButton(
      padding: const EdgeInsets.all(4),
      //padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.transparent, //Theme.of(context).colorScheme.primary,
      onPressed: () {},
      materialFlat: (_, __) => MaterialFlatButtonData(
        shape: const CircleBorder(),
      ),
      cupertino: (_, __) => CupertinoButtonData(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          StyledSwimmerAvatar(account: account, size: 100),
          const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _buildNameButton(
    BuildContext context,
    SwimmerAccount account,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () => _openEditSwimmerNamePage(
        context,
        account,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12, right: 8, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    account.fullName,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
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
    SwimmerAccount account,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () async {
        DateString selectedDate = DateString.yyyyMMdd('19900101');
        if (account.dateOfBirth != null) {
          selectedDate = DateString.yyyyMMdd(account.dateOfBirth);
        }
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate.dateTime,
          firstDate: DateTime(1900),
          lastDate: DateTime(DateTime.now().year - 1),
        );
        if (pickedDate != null) {
          AppFormat.dMMMMyyyy(DateString(pickedDate).yyyyMMdd);
          swimmerAccountListProvider.read(context).edit(
                id: account.id,
                firstName: account.firstName,
                lastName: account.lastName,
                dateOfBirth: DateString(pickedDate).yyyyMMdd,
                gender: account.gender,
              );
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
                  AppFormat.dMMMMyyyy(account.dateOfBirth),
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

  Future<Gender> _showGenderDialog(
    BuildContext context,
    SwimmerAccount account,
  ) async {
    return showPlatformDialog(
      context: context,
      builder: (_) => GenderDialog(account: account),
    );
  }

  Future<Gender> _showGenderModalPopup(
    BuildContext context,
    SwimmerAccount account,
  ) async {
    return showCupertinoModalPopup<Gender>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Choose Gender'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, Gender.female);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.transparent,
                ),
                const Text(
                  'Female',
                  textAlign: TextAlign.left,
                ),
                Icon(
                  Icons.check,
                  color: account.gender == Gender.female
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.transparent,
                )
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, Gender.male);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.transparent,
                ),
                const Text(
                  'Male',
                  textAlign: TextAlign.left,
                ),
                Icon(
                  Icons.check,
                  color: account.gender == Gender.male
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.transparent,
                )
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text(
            'Cancel',
          ),
        ),
      ),
    );
  }

  Widget _buildGenderButton(
    BuildContext context,
    SwimmerAccount account,
  ) {
    return InkWell(
      splashColor: isCupertino(context) ? Colors.transparent : null,
      onTap: () async {
        final gender = await _showGenderDialog(context, account);
//        final gender = await _showGenderModalPopup(context, account);
        if (gender != null && gender != account.gender) {
          swimmerAccountListProvider.read(context).edit(
                id: account.id,
                firstName: account.firstName,
                lastName: account.lastName,
                dateOfBirth: account.dateOfBirth,
                gender: gender,
              );
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
                  'Gender',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  account.genderString,
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
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildAvatarButton(
                      context,
                      swimmers[index],
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Column(
                        children: [
                          _buildNameButton(context, swimmers[index]),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildBirthdateButton(context, swimmers[index]),
                          const Divider(height: 1, indent: 16, endIndent: 16),
                          _buildGenderButton(context, swimmers[index]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
