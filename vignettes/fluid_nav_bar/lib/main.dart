import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;

import './demo.dart';
import 'app_constants.dart';
import 'data/app_options.dart';
import 'model/swimmer_account.dart';
import 'themes/app_theme_data.dart';

/// Create a swimmer account list and initialize it with pre-defined values
///
final swimmerAccountListProvider = StateNotifierProvider((ref) {
  return SwimmerAccountList([
    SwimmerAccount(
      firstName: 'Susie',
      lastName: "O'Neill",
      dateOfBirth: '19730802',
      gender: Gender.female,
    ),
    SwimmerAccount(
      firstName: 'Ian',
      lastName: 'Thorpe',
      dateOfBirth: '19821013',
      gender: Gender.male,
    ),
    SwimmerAccount(
      firstName: 'Cate',
      lastName: 'Campbell',
      dateOfBirth: '19920520',
      gender: Gender.female,
    )
  ]);
});

Future<void> main() async {
  await initializeDateFormatting('en_AU', null);
  intl.Intl.defaultLocale = 'en_AU';
  GoogleFonts.config.allowRuntimeFetching = true;
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
      initialModel: AppOptions(
        themeMode: ThemeMode.dark,
        textScaleFactor: AppConstants.systemTextScaleFactorOption,
        customTextDirection: CustomTextDirection.localeBased,
        locale: null,
        timeDilation: timeDilation,
        platform: defaultTargetPlatform,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Swim Club',
            debugShowCheckedModeBanner: false,
            themeMode: AppOptions.of(context).themeMode,
            theme: AppThemeData.lightThemeData.copyWith(
              platform: AppOptions.of(context).platform,
            ),
            darkTheme: AppThemeData.darkThemeData.copyWith(
              platform: AppOptions.of(context).platform,
            ),
            home: FluidNavBarDemo(),
          );
        },
      ),
    );
  }
}
