import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double height;
  final double width;
  final double textSize;
  final bool defaultLinearGradient;
  final IconData? buttonIcon;
  final bool showIcon;
  const AppButton({Key? key,required this.height,required this.width,required this.onPressed,required this.text,required this.textSize,required this.defaultLinearGradient,this.buttonIcon,this.showIcon=false}):super(key: key);
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
        splashColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Center(
              child:showIcon
                  ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: 'Comfortaa',fontSize: textSize),),
              const SizedBox(width: 5,),
              Icon(buttonIcon,color: Colors.white,size: 18),

            ],
          )
                  : Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: 'Comfortaa',fontSize: textSize),),
          ),
        ),
      ),
    );
  }
}
