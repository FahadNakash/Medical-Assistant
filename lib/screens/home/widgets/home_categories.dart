import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../../controllers/app_controller.dart';

import '../../../constant.dart';
import '../../../routes/app_pages.dart';

class HomeCategories extends StatelessWidget {
   HomeCategories({Key? key}) : super(key: key);
  final appController=AppController.appGetter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding/4),
      child: Column(
        children: [
          const SizedBox(height: kDefaultHeight/2,),
          Row(
              children: [
                Expanded(
                  flex: 3,
                  child: HomeCategory(
                      backgroundColor: const Color(0xffbef5d1),
                      child:Lottie.asset('assets/lotti/doctor.json',animate: true,repeat: true),
                      iconColor: kblue,
                      text: 'Search Specialist',
                      textColor: kblue,
                    onTap: (){
                        Get.toNamed(Routes.search_specialist,);
                        },
                  ),
                ),
                const SizedBox(width:kDefaultWidth/1.5),
                Expanded(
                  flex: 2,
                  child: HomeCategory(
                    backgroundColor: const Color(0xffF2C6C6),
                    child: Image.asset('assets/lotti/message.gif',alignment: Alignment.centerLeft,),
                    iconColor: kblue,
                    text: 'Message',
                    textColor: Colors.white,
                    onTap: (){
                      Get.toNamed(Routes.message_list);
                    },
                  ),
                ),
              ]
          ),
          const SizedBox(height: kDefaultHeight/2,),
          Row(
              children: [
                Expanded(
                  flex: 2,
                  child: HomeCategory(
                    backgroundColor: const Color(0xFFC5E3F7),
                    child: Image.asset('assets/lotti/pharmacies.gif',alignment: Alignment.centerLeft,height: 300),
                    iconColor: kblue,
                    text: 'Pharmacies',
                    textColor: Colors.white,
                    onTap: (){
                      Get.toNamed(Routes.pharmacies);
                    },
                  ),
                ),
                const SizedBox(width:kDefaultWidth/1.5),
                Expanded(
                  flex: 3,
                  child: HomeCategory(
                    backgroundColor: const Color(0xffFFF6C7),
                    child:Lottie.asset('assets/lotti/patient.json') ,
                    iconColor: kblue,
                    text: (appController.user.role=='Patient')?'My Doctors ':'My Patients',
                    textColor: kPrimaryColor,
                    onTap: (){
                      Get.toNamed(Routes.my_contacts);
                    },
                  ),
                ),
              ]
          ),
        ],
      ),
    );
  }
}

class HomeCategory extends StatelessWidget {
 final Color backgroundColor;
 final Color iconColor;
 final  Color textColor;
 final double height;
 final  String text;
 final  Widget child;
 final  Function() onTap;
  const HomeCategory({
    Key? key,
    required this.child,
    required this.backgroundColor,
    this.height=140,
    required this.iconColor,
    required this.textColor,
    required this.text,
    required this.onTap
  } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor:Colors.white,
      highlightColor: Colors.white,
      child: Container(
        height: height,
        padding: const EdgeInsets.only(bottom: kDefaultPadding,top: kDefaultPadding/3),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: child,
              ),
            ),
            const SizedBox(height: kDefaultHeight/2,),
            Text(text,style: TextStyle(color: textColor,fontFamily: 'Montserrat',fontSize: 15,fontWeight: FontWeight.bold),)
          ],
        ),

      ),
    );
  }
}

