import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
import '../../../components/app_icon.dart';
import 'package:get/get.dart';
class TextLogoAppBar extends StatelessWidget {
  const TextLogoAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenOreitation=MediaQuery.of(context).orientation;
    final size=MediaQuery.of(context).size;
    return Container(
      height: (screenOreitation==Orientation.portrait)?size.height*0.15:size.height*0.20,
      width: size.width,
      child: Stack(
        children: [
          AppIcon(height:90),
          Positioned(
            top: (screenOreitation==Orientation.portrait)?40:25,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: (){
                  Get.toNamed('/onboarding_screen/');
                },
                child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,size: 15,color: kPrimaryColor,),
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


