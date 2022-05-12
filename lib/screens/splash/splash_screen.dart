import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../models/user.dart';
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
      final prefs=await SharedPreferences.getInstance();
      final firstRun=prefs.getBool('firstRun');
      final getData=prefs.getString('userData');
      if (firstRun==null || firstRun==false){
           Get.toNamed('/onboarding_screen');
      }else if (getData==null) {
           Get.toNamed('/auth_screen');
      }else{
          Get.toNamed('/home_screen');
      }
      // Get.toNamed('/auth_screen');
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

