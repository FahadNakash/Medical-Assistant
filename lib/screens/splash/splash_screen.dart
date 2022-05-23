import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../controllers/app_controller.dart';
import '../../routes/app_pages.dart';
import '../../services/preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final appController=AppController.appGetter;
  final prefController=Preferences.preferencesGetter;

  @override
  void initState() {
    initialPage();
    super.initState();
  }
   initialPage(){
    Future.delayed(Duration(seconds: 2),()async{
      final prefs=prefController.preferences;
      final firstRun=prefs.getBool('firstRun');
      User userSession=prefController.getUserSession();
      if (firstRun==null || firstRun==false){
           Get.toNamed(Routes.onboarding);
      }else if (userSession.uid==null) {
           Get.toNamed(Routes.auth);
      }else{
         appController.user=userSession;
        Get.offAllNamed(Routes.main_home);
      }
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

