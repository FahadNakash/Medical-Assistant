import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:patient_assistant/constant.dart';
class AppButton extends StatelessWidget {
  final VoidCallback onPressend;
  final String text;
  final double height;
  final double width;
  AppButton({required this.height,required this.width,required this.onPressend,required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kInputTextColor.withOpacity(0.7),
            kPrimaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight
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
      child: TextButton(
        onPressed: onPressend,
        style: ButtonStyle(shape: MaterialStateProperty.all(StadiumBorder())),
        child: Text(text,style: TextStyle(color: Colors.white,fontFamily: 'Comfortaa'),),
      ),
    );
  }
}
