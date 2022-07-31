import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' as svg;
import 'package:get/get.dart';

import '../../utilities/utils.dart';
import '../../models/user_model.dart';
import '../../controllers/app_controller.dart';
import '../../routes/app_pages.dart';
import '../../settings/preferences.dart';


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
    Future.delayed(const Duration(seconds: 2),()async{
      final prefs=prefController.preferences;
      final firstRun=prefs.getBool('firstRun');
      UserModel userSession=prefController.getUserSession();
      if (firstRun == null || firstRun == false){
           Get.toNamed(Routes.onboarding);
      }else if (userSession.uid.isEmpty){
        Get.toNamed(Routes.auth);
      }else{
      final imagePath=await Utils().getImageLocally(userSession.uid,);
      final _imageFile=await Utils().getImageFileLocally(userSession.uid);

      appController.user = userSession;
      appController.user.imagePath=imagePath!;
      appController.user.imageFile=_imageFile!;

      Get.offAllNamed(Routes.main_home);
      }
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: svg.SvgPicture.asset('assets/images/app_logo.svg',alignment: Alignment.center,height: 70),
      ),
    );
  }
}

