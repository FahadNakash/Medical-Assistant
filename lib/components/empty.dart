import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_button.dart';
import '../constant.dart';
class Empty extends StatelessWidget{
  final String? title;
  final String middleText;
  final bool showButton;
  final VoidCallback? onPressed;
  final String image;
  final IconData? icon;
  final bool error;
   const Empty({
     Key? key,this.title,
     required this.middleText,
     this.showButton=false,
     this.onPressed,
     this.image='$kAssets/user_group.svg',
     this.icon,
     this.error=false
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool  isPotrait=(MediaQuery.of(context).orientation==Orientation.portrait)?true:false;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon==null?SvgPicture.asset(image,height: isPotrait?280:100):Icon(icon,size:isPotrait?200:100,color: kGrey,),
        SizedBox(height:isPotrait?kDefaultHeight:0),
        Text(middleText,style: kBodyText.copyWith(color: error?kErrorColor:Colors.black.withOpacity(0.7)),textAlign: TextAlign.center),
        SizedBox(height:isPotrait?kDefaultHeight:0),
        if (showButton)
        AppButton(
            height: 35,
            width: 90,
            onPressed: onPressed!,
            text: 'Lets Go',
            textSize: 12,
            defaultLinearGradient: true
        )
      ],
    );
  }
}
