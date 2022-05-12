import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/screens/splash/splash_screen.dart';
import 'package:patient_assistant/theme.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'binding/all_controller_binding.dart';
import 'screens/onboarding/onbaording_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/role/role_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/mainscreen/main_screen.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:  kPrimaryColor,
        systemNavigationBarColor: kPrimaryColor,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
          systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: kPrimaryColor,

      ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllControllerBinding(),
      title: 'Medical Assistant',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      home: MainScreen(),
      getPages: [
        GetPage(name: '/auth_screen', page: ()=>AuthScreen(),transition: Transition.rightToLeft),
        GetPage(name: '/onboarding_screen', page: ()=>OnBoardingScreen(),transition: Transition.rightToLeft),
        GetPage(name: '/role_screen', page: ()=>RoleScreen(),transition: Transition.leftToRight,),
        GetPage(name: '/home_screen', page: ()=>HomeScreen()),
        GetPage(name: '/main_screen', page: ()=>MainScreen()),

      ],
    );
  }
}
