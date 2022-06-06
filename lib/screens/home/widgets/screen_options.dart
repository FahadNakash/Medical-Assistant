import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../routes/app_pages.dart';

class ScreenOptions extends StatelessWidget {
  const ScreenOptions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final orientation=MediaQuery.of(context).orientation;
    return Column(
      children: [
        Row(
            children: [
              Expanded(
                flex: 3,
                child: ScreenNavigatonBox(
                    color: Color(0xffbef5d1),
                    child:Lottie.asset('assets/lotti/doctor.json',animate: true,repeat: true),
                    iconColor: kHeading2Color,
                    text: 'Search Specialist',
                    textColor: kHeading2Color,
                  onTap: (){
                      Get.toNamed(Routes.search_specialist);
                      },
                ),
              ),
              SizedBox(width:kDefaultWidth/1.5),
              Expanded(
                flex: 2,
                child: ScreenNavigatonBox(
                  color: Color(0xffF2C6C6),
                  child: Image.asset('assets/lotti/message.gif',alignment: Alignment.centerLeft,),
                  iconColor: kHeading2Color,
                  text: 'Message',
                  textColor: Colors.white,
                  onTap: (){
                    Get.toNamed(Routes.chat);
                  },
                ),
              ),
            ]
        ),
        SizedBox(height: kDefaultHeight/2,),
        Row(
            children: [
              Expanded(
                flex: 2,
                child: ScreenNavigatonBox(
                  color: Color(0xFFC5E3F7),
                  child: Image.asset('assets/lotti/pharmacies.gif',alignment: Alignment.centerLeft,height: 300),
                  iconColor: kHeading2Color,
                  text: 'Pharmacies',
                  textColor: Colors.white,
                  onTap: (){
                    Get.toNamed(Routes.pharmacies);
                  },
                ),
              ),
              SizedBox(width:kDefaultWidth/1.5),
              Expanded(
                flex: 3,
                child: ScreenNavigatonBox(
                  color: Color(0xffFFF6C7),
                  child:Lottie.asset('assets/lotti/patient.json') ,
                  iconColor: kHeading2Color,
                  text: 'My Patients',
                  textColor: kPrimaryColor,
                  onTap: (){
                    Get.toNamed(Routes.my_patients);
                  },
                ),
              ),
            ]
        ),
      ],
    );
  }
}

class ScreenNavigatonBox extends StatelessWidget {
  Color color;
  Color iconColor;
  Color textColor;
  double height;
  String text;
  Widget child;
  Function() onTap;
  ScreenNavigatonBox({
    Key? key,
    required this.child,
    required this.color,
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
        padding: EdgeInsets.only(bottom: kDefaultPadding,top: kDefaultPadding/3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: child,
              ),
            ),
            SizedBox(height: kDefaultHeight/2,),
            Text(text,style: TextStyle(color: textColor,fontFamily: 'Montserrat',fontSize: 15,fontWeight: FontWeight.bold),)
          ],
        ),

      ),
    );
  }
}

