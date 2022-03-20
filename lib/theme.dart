import 'package:flutter/material.dart';
import 'constant.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      splashColor: kPrimaryColor,
      textTheme: Theme.of(context).textTheme.copyWith(
          headline5: TextStyle(
              color: kHeadingColor,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600
          ),
          bodyText1: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'Comfortaa',
              fontSize: 13
          ),
          bodyText2: TextStyle(
          color: kHeading2Color,
          fontFamily: 'Comfortaa',
          fontSize: 30
      )
      )
  );
}
