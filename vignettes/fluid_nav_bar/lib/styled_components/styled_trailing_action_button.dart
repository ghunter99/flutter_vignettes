import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class StyledTrailingActionButton extends StatelessWidget {
  StyledTrailingActionButton(this.title, this.onPressed);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8, bottom: 0),
      child: PlatformButton(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        color: Theme.of(context).colorScheme.primaryVariant,
        onPressed: onPressed,
        materialFlat: (_, __) => MaterialFlatButtonData(
          shape: const StadiumBorder(),
        ),
        cupertino: (_, __) => CupertinoButtonData(
          color: Theme.of(context).colorScheme.primaryVariant,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
