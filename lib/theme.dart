import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      splashColor: kPrimaryColor,
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
          color: kTextColor,
          fontFamily: 'Comfortaa',
          fontSize: 12,
        )
      )
  );
}
