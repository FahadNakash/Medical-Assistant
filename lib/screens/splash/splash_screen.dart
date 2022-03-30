import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../models/auth_user.dart';
import '../onboarding/onbaording_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initialPage();
    super.initState();
  }
   initialPage(){
    Future.delayed(Duration(seconds: 2),()async{
      final authController=AuthController.authGetter;
      final prefs=await SharedPreferences.getInstance();
       final getData=prefs.getString('userData');
       final firstRun=prefs.getBool('firstRun');
        print(getData);
       print(firstRun);
       if (firstRun!=true && getData==null){
         Get.toNamed('/onboarding_screen');
       }else{
         Get.toNamed('/auth_screen');
       }

       // if (getData!=null){
       //     //print('userData is not null so the data is ${getData}');
       //     final decodeData=json.decode(getData);
       //     //print(decodeData);
       //     if (decodeData['formid']!=null){
       //       final AuthUser userData=AuthUser.fromJson(decodeData);
       //       Get.toNamed('/home_screen',arguments: userData);
       //     }else{
       //       Get.toNamed('/role_screen');
       //     }
       //     //print(decodeData);
       //    //print(userData);
       // }else{
       //   //print('User Data is null');
       //  Get.to(()=>OnBoardingScreen(),transition: Transition.fade);
       // }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: svg.SvgPicture.asset('assets/images/app_logo.svg',alignment: Alignment.center,height: 70),
        ),
      ),
    );
  }
}

