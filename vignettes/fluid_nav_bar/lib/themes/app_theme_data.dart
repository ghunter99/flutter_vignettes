// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: colorScheme.brightness,
      ),

      /// The `displayColor` is applied to
      /// [headline4], [headline3], [headline2], [headline1], and [caption].
      /// The `bodyColor` is applied to the remaining text styles.
      textTheme: _textTheme.apply(
        displayColor: colorScheme.primary,
        bodyColor: colorScheme.onPrimary,
      ),
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        textTheme: _textTheme.apply(bodyColor: colorScheme.primary),
        color: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
        brightness: colorScheme.brightness,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.background,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
      ),
      dividerTheme:
          DividerThemeData(color: colorScheme.onSecondary, thickness: 1),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      accentColor: colorScheme.primary,
      focusColor: focusColor,
      cardColor: colorScheme.secondary,
      bottomAppBarColor: colorScheme.surface,
      textSelectionColor: colorScheme.primary,
      cursorColor: colorScheme.primary,
      textSelectionHandleColor: colorScheme.primary,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFF8383), //Color(0xFFB93C5D),
    primaryVariant: Color(
        0xFF1CDEC9), //Color.fromRGBO(76, 31, 124, 1), //Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryVariant: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: Colors.red,
    onPrimary: _lightFillColor,
    onSecondary: Colors.grey, //Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryVariant: Color(0xFF1CDEC9),
    secondary: Color.fromRGBO(76, 31, 124, 1), //Color(0xFF4D1F7C),
    secondaryVariant: Color(0xFF451B6F),
    background: Color.fromRGBO(69, 27, 111, 1), //Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: Colors.yellow,
    onPrimary: _darkFillColor,
    onSecondary: Colors.grey,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  //static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    //
    // displayColor is applied to these text themes
    //
    headline1: GoogleFonts.dancingScript(fontWeight: _regular, fontSize: 48.0),
    headline2: GoogleFonts.dancingScript(fontWeight: _regular, fontSize: 32.0),
    headline3: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 22.0),
    headline4: GoogleFonts.lato(fontWeight: _regular, fontSize: 22.0),
    caption: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 20.0),
    //
    // bodyColor is applied to these text themes
    //
    headline5: GoogleFonts.lato(fontWeight: _medium, fontSize: 18.0),
    // used by appBar title, dialog title
    headline6: GoogleFonts.balooTamma(fontWeight: _medium, fontSize: 24.0),
//    headline6: GoogleFonts.dancingScript(fontWeight: _bold, fontSize: 28.0),
    // used by card title, dialog content, text form, chip label
    subtitle1: GoogleFonts.lato(fontWeight: _regular, fontSize: 18.0),
    subtitle2: GoogleFonts.lato(fontWeight: _medium, fontSize: 16.0),
    bodyText1: GoogleFonts.lato(fontWeight: _regular, fontSize: 18.0),
    // used by card subtitle
    bodyText2: GoogleFonts.lato(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 14.0),
    // used by button
    button: GoogleFonts.lato(fontWeight: _semiBold, fontSize: 18.0),
  );
}
