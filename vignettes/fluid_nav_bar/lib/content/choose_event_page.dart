import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../app_constants.dart';

class ChooseEventPage extends StatefulWidget {
  const ChooseEventPage(this.currentEvent);
  final SwimEvent currentEvent;

  @override
  _ChooseEventPageState createState() => _ChooseEventPageState();
}

class _ChooseEventPageState extends State<ChooseEventPage> {
  SwimEvent _chosenEvent;

  @override
  void initState() {
    super.initState();
    _chosenEvent = widget.currentEvent;
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
        'Event',
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

  Widget _buildEventLabel(
    BuildContext context, {
    @required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 24, bottom: 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.overline,
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceChip(
    BuildContext context, {
    @required SwimEvent event,
  }) {
    final items = event.toString().split(' ');
    final distance = items[1];
    return ChoiceChip(
      key: Key(event.toString()),
      elevation: isMaterial(context) ? null : 0,
      shadowColor: isMaterial(context) ? null : Colors.transparent,
      selectedShadowColor: isMaterial(context) ? null : Colors.transparent,
      labelPadding:
          const EdgeInsets.only(left: 16, top: 6, right: 24, bottom: 8),
      label: Text(
        distance.padLeft(4),
        style: Theme.of(context).textTheme.headline3.copyWith(
              color: Colors.white,
            ),
      ),
      selected: _chosenEvent == event,
      onSelected: (_) {
        setState(() {
          _chosenEvent = event;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Future<void>.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context, _chosenEvent);
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
          body: ListView(
            children: [
              _buildEventLabel(context, label: 'FREESTYLE'),
              Container(
                height: 64,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 24),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.freestyle25m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.freestyle50m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.freestyle100m,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildEventLabel(context, label: 'BACKSTROKE'),
              Container(
                height: 64,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 24),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.backstroke25m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.backstroke50m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.backstroke100m,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildEventLabel(context, label: 'BREASTSTROKE'),
              Container(
                height: 64,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 24),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.breaststroke25m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.breaststroke50m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.breaststroke100m,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildEventLabel(context, label: 'BUTTERFLY'),
              Container(
                height: 64,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 24),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.butterfly25m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.butterfly50m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.butterfly100m,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildEventLabel(context, label: 'INDIVIDUAL MEDLEY'),
              Container(
                height: 64,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 24),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.medley100m,
                          ),
                          const SizedBox(width: 16),
                          _buildChoiceChip(
                            context,
                            event: SwimEvent.medley200m,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
