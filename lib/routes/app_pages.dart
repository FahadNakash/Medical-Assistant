import 'package:get/get.dart';
import 'package:patient_assistant/screens/my_contacts/my_contacts_screen.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/role/role_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/drawer_home/drawer_home_screen.dart';
import '../screens/profile/user_profile_screen.dart';
import '../screens/search_specialist/search_specialist_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/pharmacies/pharmacies_location_screen.dart';
import '../binding/auth_binding.dart';
import '../binding/role_binding.dart';
import '../binding/user_profile_binding.dart';

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
        page: ()=> const DrawerHomeScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
        name: Routes.user_profile,
        page: ()=>const UserProfileScreen(),
        transition: Transition.leftToRight,
      binding: UserProfileBinding()
    ),
    GetPage(
        name: Routes.search_specialist,
        page: ()=>const SearchSpecialistScreen(),
        transition: Transition.size,
    ),
    GetPage(
      name: Routes.chat,
      page: ()=>const ChatScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.pharmacies,
      page: ()=>const PharmaciesLocationScreen(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: Routes.my_contacts,
      page: ()=>  MyContactsScreen(),
      transition: Transition.leftToRight,
    ),
  ];



}