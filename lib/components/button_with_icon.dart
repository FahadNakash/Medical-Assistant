import 'package:flutter/material.dart';

import '../constant.dart';
class ButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double iconSize;
  final String text;
  final double height;
  final double width;
  final bool defaultLinearGradient;
  final double textSize;
  const ButtonWithIcon({Key? key,this.width=80,this.height=30,required this.defaultLinearGradient,this.textSize=10,required this.onPressed,required this.text,required this.icon,required this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            // ignore: use_full_hex_values_for_flutter_colors
            Color(0xff037e87f),
            kPrimaryColor,
          ],
          begin:defaultLinearGradient?Alignment.topLeft:Alignment.topRight,
          end:  defaultLinearGradient?Alignment.topRight:Alignment.topLeft,
        ),
        boxShadow: [
          BoxShadow(
            color:Colors.grey.withOpacity(0.9),
            blurRadius: 10,
            offset: const Offset(0,4),
          ),
          const BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              offset: Offset(-5,-5),
              spreadRadius: 1
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: 'Comfortaa',fontSize: textSize,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  Icon(icon,color: Colors.white,size: iconSize,)
                ],
              )),
        ),
      ),
    );
  }
}
