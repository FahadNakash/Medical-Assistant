import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../components/app_icon.dart';
import '../../../routes/app_pages.dart';

class TextLogoAppBar extends StatelessWidget {
  const TextLogoAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenOrientation=MediaQuery.of(context).orientation;
    final size=MediaQuery.of(context).size;
    return SizedBox(
      height: (screenOrientation==Orientation.portrait)?size.height*0.15:size.height*0.20,
      width: size.width,
      child: Stack(
        children: [
          const AppIcon(height:kDefaultHeight*4+10),
          Positioned(
            top: (screenOrientation==Orientation.portrait)?40:25,
            child: Padding(
              padding:  const EdgeInsets.only(left: kDefaultPadding/4),
              child: InkWell(
                highlightColor: Colors.white,
                onTap: (){
                  Get.toNamed(Routes.onboarding);
                },
                child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios,size: 15,color: kPrimaryColor,),
                        Text('Intro',style: Theme.of(context).textTheme.bodyText1,)
                      ],
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


