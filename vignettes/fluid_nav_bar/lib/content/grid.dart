import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class GridContent extends StatelessWidget {
  Widget _buildSettingsButton(BuildContext context) {
    if (isMaterial(context)) {
      return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.settings,
          color: Colors.white,
        ),
      );
    }
    return PlatformButton(
      onPressed: () {},
      child: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildSettingsButton(context),
            )
          ],
        ),
      ],
    );
  }
}
