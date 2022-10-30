import 'package:flutter/material.dart';

import '../constant.dart';
class CustomOutlineButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String text;
  final double borderRadius;
  final double fontSize;
  const CustomOutlineButton({Key? key,this.height=30,this.width=50,required this.onTap,required this.text,this.borderRadius=15,this.fontSize=10}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      highlightColor: Colors.white,
      splashColor: Colors.white,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: const Color(0xff36EA7B))
        ),
        child:  Text(text,style:  TextStyle(color: kHeading1Color,fontSize: fontSize,fontWeight: FontWeight.bold)),

      ),
    );
  }
}
