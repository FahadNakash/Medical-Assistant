import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/role/role_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/drawer_home/drawer_home_screen.dart';
import '../binding/auth_binding.dart';
import '../binding/role_binding.dart';
import '../screens/profile/user_profile_screen.dart';

 part 'app_routes.dart';
class AppPages{
  AppPages._();

  static const String initial=Routes.splash;

  static final routes=[
    GetPage(
      name:Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: Routes.onboarding,
        page: ()=> const OnBoardingScreen(),
        transition: Transition.rightToLeft
    ),
    GetPage(
        name: Routes.auth,
        page: ()=> const AuthScreen(),
        transition: Transition.rightToLeft,
        binding: AuthBinding()
    ),
    GetPage(
        name: Routes.role,
        page: ()=> RoleScreen(),
        transition: Transition.leftToRight,
        binding:RoleBinding()
    ),
    GetPage(
        name: Routes.main_home,
        page: ()=> DrawerHomeScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
        name: Routes.user_profile,
        page: ()=>UserProfile(),
        transition: Transition.leftToRight,
    )

  ];



}