import 'package:flutter/material.dart';
class SizeConfig{
  static MediaQueryData? _mediaQueryData;
  static double? screenHeight;
  static double? screenWidth;
  static double? conatinersizeH;
  static double? containersizeV;
  static void setSize(BuildContext context){
    _mediaQueryData=MediaQuery.of(context);
    screenHeight=_mediaQueryData!.size.height;
    screenWidth=_mediaQueryData!.size.width;
    conatinersizeH=screenWidth! / 100;
    containersizeV=screenWidth!/100;
  }

}