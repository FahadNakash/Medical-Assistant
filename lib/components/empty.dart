import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_button.dart';
import '../constant.dart';
class Empty extends StatelessWidget {
  final String? title;
  final String middleText;
  final bool showButton;
  final VoidCallback? onPressed;
  final String image;
   const Empty({
     Key? key,this.title,
     required this.middleText,
     this.showButton=false,
     this.onPressed,
     this.image='$kImagePath/user_group.svg'
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool  isPotrait=(MediaQuery.of(context).orientation==Orientation.portrait)?true:false;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          SvgPicture.asset(image,height: isPotrait?null:100),
          SizedBox(height:isPotrait?kDefaultHeight:0),
          Text(middleText,style: kBodyText,textAlign: TextAlign.center),
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
      ),
    );
  }
}
