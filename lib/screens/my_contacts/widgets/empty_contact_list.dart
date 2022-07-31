import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../../constant.dart';
import '../../../routes/app_pages.dart';
class EmptyContactList extends StatelessWidget {
  final String title;
  final String middleText;
  final bool showButton;
   const EmptyContactList({Key? key,required this.title,required this.middleText,this.showButton=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          Text(title,style:const TextStyle(color: kHeading2Color, fontFamily: 'Montserrat', fontSize: 25,fontWeight: FontWeight.w700),),
          const SizedBox(height: kDefaultHeight),
          SvgPicture.asset('assets/images/user_group.svg',),
          const SizedBox(height: kDefaultHeight),
          Text(middleText,style: kBodyText,),
          //Text('Look like you have not added any Specialist to your profile.Head over to search screen to add some specialist',style: kBodyText,),
          const SizedBox(height: kDefaultHeight),
          if (showButton)
          AppButton(
              height: 35,
              width: 90,
              onPressed: (){
                Get.toNamed(Routes.search_specialist,);
              },
              text: 'Lets Go',
              textSize: 12,
              defaultLinearGradient: true
          )
        ],
      ),
    );
  }
}
