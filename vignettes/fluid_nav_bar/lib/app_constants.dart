// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Only put constants shared between files here.

class SwimEvent {
  const SwimEvent._(this._name);
  final String _name;
  @override
  String toString() {
    return _name;
  }

  // freestyle events
  static const SwimEvent freestyle25m = SwimEvent._('Freestyle 25m');
  static const SwimEvent freestyle50m = SwimEvent._('Freestyle 50m');
  static const SwimEvent freestyle100m = SwimEvent._('Freestyle 100m');
  static const SwimEvent freestyle200m = SwimEvent._('Freestyle 200m');
  // backstroke events
  static const SwimEvent backstroke25m = SwimEvent._('Backstroke 25m');
  static const SwimEvent backstroke50m = SwimEvent._('Backstroke 50m');
  static const SwimEvent backstroke100m = SwimEvent._('Backstroke 100m');
  // breaststroke events
  static const SwimEvent breaststroke25m = SwimEvent._('Breaststroke 25m');
  static const SwimEvent breaststroke50m = SwimEvent._('Breaststroke 50m');
  static const SwimEvent breaststroke100m = SwimEvent._('Breaststroke 100m');
  // butterfly events
  static const SwimEvent butterfly25m = SwimEvent._('Butterfly 25m');
  static const SwimEvent butterfly50m = SwimEvent._('Butterfly 50m');
  static const SwimEvent butterfly100m = SwimEvent._('Butterfly 100m');
  // medley events
  static const SwimEvent medley100m = SwimEvent._('Medley 100m');
  static const SwimEvent medley200m = SwimEvent._('Medley 200m');
}

class AppConstants {
  // height of the 'Gallery' header
  static const double galleryHeaderHeight = 64;

  // The font size delta for headline4 font.
  static const double desktopDisplay1FontDelta = 16;

  // The width of the settingsDesktop.
  static const double desktopSettingsWidth = 520;

  // Sentinel value for the system text scale factor option.
  static const double systemTextScaleFactorOption = -1;

  // The splash page animation duration.
  static const splashPageAnimationDurationInMilliseconds = 300;

  // The desktop top padding for a page's first header (e.g. Gallery, Settings)
  static const firstHeaderDesktopTopPadding = 5.0;

  static const firstSwimLane = 1;
  static const lastSwimLane = 10;
}
