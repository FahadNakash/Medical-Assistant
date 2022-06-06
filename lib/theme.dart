import 'package:flutter/material.dart';
import 'constant.dart';
ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSwatch(
          accentColor: kInputTextColor,
         primaryColorDark: kPrimaryColor
      ),
      splashColor: kPrimaryColor,
      primaryColorLight: kPrimaryColor,
      textTheme: Theme.of(context).textTheme.copyWith(
          headline5: TextStyle(
              color: kHeading1Color,
              fontFamily: 'Comfortaa',
              fontSize: 30,
              fontWeight: FontWeight.normal
          ),
          bodyText1: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'Comfortaa',
              fontSize: 13
          ),
          bodyText2: TextStyle(
          color: kHeading2Color,
          fontFamily: 'Comfortaa',
          fontSize: 30,
            fontStyle: FontStyle.normal,
      ),
          subtitle1: TextStyle(
          color: kTextColor.withOpacity(0.7),
          fontFamily: 'Comfortaa',
          fontSize: 12,
        ),
        //chip text
         subtitle2: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontFamily: 'Comfortaa',
           fontWeight: FontWeight.bold,
        ),
      ),
    errorColor: kErrorColor,
    focusColor: kHeading1Color,
    hintColor: kHeading1Color,
    progressIndicatorTheme: ProgressIndicatorThemeData(
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
