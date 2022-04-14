import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final double textSize;
  final bool defaultLinearGradient;
  AppButton({required this.height,required this.width,required this.onPressed,required this.text,required this.textSize,required this.defaultLinearGradient});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff037E87F),
            kPrimaryColor,
          ],
          begin:defaultLinearGradient?Alignment.topLeft:Alignment.topRight,
          end:  defaultLinearGradient?Alignment.topRight:Alignment.topLeft,
        ),
        boxShadow: [
          BoxShadow(
              color:Colors.grey.withOpacity(0.9),
              blurRadius: 10,
              offset: Offset(0,4),
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(-5,-5),
            spreadRadius: 1
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Center(child: Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: 'Comfortaa',fontSize: textSize),)),
        ),
      ),
    );
  }
}
