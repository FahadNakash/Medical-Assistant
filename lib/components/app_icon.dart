import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AppIcon extends StatelessWidget {
  final double height;
  AppIcon({required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17),
      height: height,
      width: double.infinity,
      child: SvgPicture.asset('assets/images/app_logo.svg',),


    );
  }
}
