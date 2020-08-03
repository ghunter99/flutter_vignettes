import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as Intl;

import './demo.dart';
import 'constants.dart';
import 'data/gallery_options.dart';
import 'model/swimmer_account.dart';
import 'themes/gallery_theme_data.dart';

/// Create a swimmer account list and initialize it with pre-defined values
///
final swimmerAccountListProvider = StateNotifierProvider((ref) {
  return SwimmerAccountList([
    SwimmerAccount(
      firstName: 'Susie',
      lastName: "O'Neill",
      dateOfBirth: '19730802',
      gender: Gender.female,
    )
  ]);
});

void main() async {
  await initializeDateFormatting('en_AU', null);
  Intl.Intl.defaultLocale = 'en_AU';
  runApp(const ProviderScope(child: App()));
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
        themeMode: ThemeMode.dark,
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
            theme: GalleryThemeData.darkThemeData.copyWith(
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
