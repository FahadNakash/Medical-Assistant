import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patient_assistant/components/custom_outline_button.dart';

import 'package:patient_assistant/constant.dart';
class NavigatorTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final String subtitle;
  final Color backgroundColor;
  final VoidCallback onTap;
  final Color iconColor;
  final double height;
  final double width;
  final bool showBorder;
  final bool showOutlineButton;
  const NavigatorTile({Key? key,required this.imagePath,required this.title,required this.subtitle,required this.backgroundColor,required this.onTap,this.iconColor=Colors.white,this.height=26,this.width=26,this.showBorder=true,this.showOutlineButton=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:showOutlineButton?null:onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: showBorder?kDefaultPadding*5:kDefaultPadding*4,
        margin: showBorder?const EdgeInsets.symmetric(horizontal: 10,vertical: 10):const EdgeInsets.symmetric(horizontal: 10,),
        decoration:showBorder?BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kGrey.withOpacity(0.2))
        ):null,
        child: Row(
          children: [
            Container(
              margin:  const EdgeInsets.only(left:10),
              padding: const EdgeInsets.all(kDefaultPadding/2),
              decoration:BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: SvgPicture.asset(imagePath,color: iconColor,fit: BoxFit.fill,width: width,height: height),
            ),
             SizedBox(width:showOutlineButton?10:15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: kSearchHeading3.copyWith(fontSize: 17),),
                  const SizedBox(height: 5),
                  Text(subtitle,style:TextStyle(color: kGrey.withOpacity(0.8),fontSize:11),softWrap: true,)
                ],
              ),
            ),
             showOutlineButton
                 ?CustomOutlineButton(onTap: onTap, text: 'add')
                 :const Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child:Icon(Icons.arrow_forward_ios,color: kSecondaryColor,),
            ),


          ],
        ),
      ),
    );
  }
}
