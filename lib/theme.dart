import 'package:flutter/material.dart';

import 'constant.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kInputTextColor,
      selectionHandleColor: kInputTextColor,
      //cursorColor: Colors.blue
    ),
    highlightColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
        accentColor: kInputTextColor,
        // primaryColorDark: kPrimaryColor,
        backgroundColor: Colors.white),
    splashColor: kPrimaryColor,
    primaryColorLight: kPrimaryColor,
    textTheme: Theme.of(context).textTheme.copyWith(
          headline5: const TextStyle(
              color: kHeading1Color,
              fontFamily: 'Comfortaa',
              fontSize: 30,
              fontWeight: FontWeight.normal),
          bodyText1: const TextStyle(
              color: kPrimaryColor, fontFamily: 'Comfortaa', fontSize: 13),
          bodyText2: const TextStyle(
            color: kblue,
            fontFamily: 'Comfortaa',
            fontSize: 30,
            fontStyle: FontStyle.normal,
          ),
          subtitle1: TextStyle(
            color: kGrey.withOpacity(0.7),
            fontFamily: 'Comfortaa',
            fontSize: 12,
          ),
          //chip text
          subtitle2: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
          ),
        ),
    errorColor: kErrorColor,
    focusColor: kHeading1Color,
    hintColor: kHeading1Color,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: kPrimaryColor,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(kPrimaryColor),
    ),
    androidOverscrollIndicator: AndroidOverscrollIndicator.glow,
    scaffoldBackgroundColor: Colors.white,
    hoverColor: kPrimaryColor,
  );
}
