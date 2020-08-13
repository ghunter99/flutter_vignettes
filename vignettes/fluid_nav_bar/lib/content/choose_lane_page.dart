import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../app_constants.dart';

class ChooseLanePage extends StatefulWidget {
  const ChooseLanePage(this.currentLane);
  final int currentLane;

  @override
  _ChooseLanePageState createState() => _ChooseLanePageState();
}

class _ChooseLanePageState extends State<ChooseLanePage> {
  int _chosenLane;

  @override
  void initState() {
    super.initState();
    _chosenLane = widget.currentLane;
  }

  Widget _buildCancelButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () {
          Navigator.pop(context, null);
        },
        icon: const Icon(
          Icons.close,
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
    @required int lane,
  }) {
    return ChoiceChip(
      key: Key('$lane'),
      elevation: isMaterial(context) ? null : 0,
      shadowColor: isMaterial(context) ? null : Colors.transparent,
      selectedShadowColor: isMaterial(context) ? null : Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      label: Container(
        constraints:
            BoxConstraints(minWidth: MediaQuery.of(context).size.width - 64),
        child: Text(
          'Lane $lane',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      selected: _chosenLane == lane,
      onSelected: (_) {
        setState(() {
          _chosenLane = lane;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Future<void>.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context, _chosenLane);
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
            itemCount:
                AppConstants.lastSwimLane - AppConstants.firstSwimLane + 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _buildChoiceChip(
                      context,
                      lane: AppConstants.firstSwimLane + index,
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
