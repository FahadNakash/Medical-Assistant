import 'package:get/get.dart';

import '../screens/message/messages_list_screen.dart';
import '../screens/my_contacts/my_contacts_screen.dart';
import '../screens/search_disease/search_disease_screen.dart';
import '../screens/search_drug/drugs_detail_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/role/role_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/drawer_home/drawer_home_screen.dart';
import '../screens/profile/user_profile_screen.dart';
import '../screens/search_specialist/search_specialist_screen.dart';
import '../screens/pharmacies/pharmacies_location_screen.dart';
import '../binding/auth_binding.dart';
import '../binding/role_binding.dart';
import '../binding/user_profile_binding.dart';
import '../screens/message/chat_screen.dart';
import '../screens/search_drug/search_drug_screen.dart';

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
      name: Routes.message_list,
      page: ()=> const MessagesListScreen(),
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
    GetPage(
      name: Routes.chat,
      page: ()=>  const ChatScreen(),
    ),
    GetPage(
      name: Routes.search_drug,
      page: ()=>  const SearchDrugScreen(),
    ),
    GetPage(
      name: Routes.drug_detail,
      page: ()=>   DrugDetailScreen(),
    ),
    GetPage(
      name: Routes.search_disease,
      page: ()=>  const SearchDiseaseScreen(),
      transition: Transition.fadeIn
    ),

  ];



}