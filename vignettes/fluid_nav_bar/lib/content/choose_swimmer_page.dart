import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../model/swimmer_account.dart';

class ChooseSwimmerPage extends StatefulWidget {
  const ChooseSwimmerPage(
    this.currentSwimmer,
    this.swimmerList,
  );
  final SwimmerAccount currentSwimmer;
  final List<SwimmerAccount> swimmerList;

  @override
  _ChooseSwimmerPageState createState() => _ChooseSwimmerPageState();
}

class _ChooseSwimmerPageState extends State<ChooseSwimmerPage> {
  SwimmerAccount _chosenSwimmer;

  @override
  void initState() {
    super.initState();
    _chosenSwimmer = widget.currentSwimmer;
  }

  Widget _buildCancelButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () {
          Navigator.pop(context, null);
        },
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }
    return PlatformButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pop(context, null);
      },
      cupertino: (_, __) => CupertinoButtonData(
        padding: EdgeInsets.zero,
      ),
      child: Icon(
        Icons.close,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  PlatformAppBar _buildAppBar(BuildContext context) {
    return PlatformAppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Lane',
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      trailingActions: <Widget>[
        _buildCancelButton(context),
      ],
      cupertino: (_, __) => CupertinoNavigationBarData(
        padding: const EdgeInsetsDirectional.only(start: 0, end: 0),
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

  Widget _buildChoiceChip(
    BuildContext context, {
    @required SwimmerAccount swimmer,
  }) {
    return ChoiceChip(
      key: Key(swimmer.id),
      elevation: isMaterial(context) ? null : 0,
      shadowColor: isMaterial(context) ? null : Colors.transparent,
      selectedShadowColor: isMaterial(context) ? null : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      label: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width - 64),
        child: Text(
          swimmer.fullName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      selected: _chosenSwimmer.id == swimmer.id,
      onSelected: (_) {
        setState(() {
          _chosenSwimmer = swimmer;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Future<void>.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context, _chosenSwimmer);
            });
          });
        });
      },
      selectedColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: PlatformScaffold(
          appBar: _buildAppBar(context),
          body: ListView.builder(
            itemCount: widget.swimmerList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildChoiceChip(
                      context,
                      swimmer: widget.swimmerList[index],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
