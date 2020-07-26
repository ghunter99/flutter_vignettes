import 'package:fluid_nav_bar/themes/gallery_theme_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import './demo.dart';
import 'constants.dart';
import 'data/gallery_options.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({
    Key key,
//    this.initialRoute,
    this.isTestMode = false,
  }) : super(key: key);

  final bool isTestMode;
//  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: GalleryOptions(
        themeMode: ThemeMode.system,
        textScaleFactor: Constants.systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: null,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Gallery',
            debugShowCheckedModeBanner: false,
            themeMode: GalleryOptions.of(context).themeMode,
            theme: GalleryThemeData.lightThemeData.copyWith(
              platform: GalleryOptions.of(context).platform,
            ),
            darkTheme: GalleryThemeData.darkThemeData.copyWith(
              platform: GalleryOptions.of(context).platform,
            ),
//            localizationsDelegates: const [
//              ...GalleryLocalizations.localizationsDelegates,
//              LocaleNamesLocalizationsDelegate()
//            ],
//            initialRoute: initialRoute,
            home: FluidNavBarDemo(),
//            supportedLocales: GalleryLocalizations.supportedLocales,
//            locale: GalleryOptions.of(context).locale,
//            localeResolutionCallback: (locale, supportedLocales) {
//              deviceLocale = locale;
//              return locale;
//            },
//            onGenerateRoute: RouteConfiguration.onGenerateRoute,
          );
        },
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: FluidNavBarDemo(),
//    );
//  }
}
