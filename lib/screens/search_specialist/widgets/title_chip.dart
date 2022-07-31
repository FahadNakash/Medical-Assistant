import 'package:flutter/material.dart';

import '../../../constant.dart';
class TitleChip extends StatelessWidget {
  final String title;
  const TitleChip({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 2),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(bottomRight:Radius.circular(20),topRight:Radius.circular(20)),
        gradient: LinearGradient(
          colors:[
            kSecondaryColor,
            kPrimaryColor
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Text(title,style:const TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontWeight: FontWeight.w600,fontSize: 15)),
    );
  }
}
