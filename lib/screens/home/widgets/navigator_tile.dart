import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:patient_assistant/constant.dart';
class NavigatorTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;
  const NavigatorTile({Key? key,required this.imagePath,required this.title,required this.subtitle,required this.iconColor,required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        height: kDefaultPadding*5,
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: kGrey.withOpacity(0.2))
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(kDefaultPadding/2),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: SvgPicture.asset(imagePath,color: Colors.white,fit: BoxFit.fill,width: 26,height: 26),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: kSearchHeading3.copyWith(fontSize: 17),),
                  const SizedBox(height: 5),
                  Text(subtitle,style:TextStyle(color: kGrey.withOpacity(0.8),fontSize: 11),softWrap: true,)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
              child: Icon(Icons.arrow_forward_ios,color: kSecondaryColor,),
            )
          ],
        ),
      ),
    );
  }
}
