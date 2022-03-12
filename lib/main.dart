import 'package:flutter/material.dart';
import 'package:patient_assistant/theme.dart';
import 'binding/all_controller_binding.dart';
import 'screens/onboarding/onbaording_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'package:get/get.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllControllerBinding(),
      title: 'Medical Assistant',
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      home: OnBoardingScreen(),
      getPages: [
        GetPage(name: '/auth_screen', page: ()=>AuthScreen(),transition: Transition.rightToLeft),
        GetPage(name: '/onboarding_screen', page: ()=>OnBoardingScreen(),transition: Transition.rightToLeft)
      ],
    );
  }
}
