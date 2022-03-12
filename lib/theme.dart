import 'package:flutter/material.dart';
import 'constant.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
      textTheme: Theme.of(context).textTheme.copyWith(
          headline5: TextStyle(
              color: kHeadingColor,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600),
          bodyText1: TextStyle(
              color: kPrimaryColor,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold)
      )
  );
}
