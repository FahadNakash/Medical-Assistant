import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';
import 'controllers/app_controller.dart';
import 'controllers/role_controller.dart';
import 'controllers/user_profile_controller.dart';
import 'settings/preferences.dart';
import 'services/firestore_helper.dart';

const kPrimaryColor= Color(0xff23AFB3);
const kErrorColor= Color(0xffe75c5c);
const kHeading1Color= Color(0xff37E87F);
const kHeading2Color=Color(0xff2d6fa2);
const kTextColor=Color(0xff7b939f);
const kInputBgColor=Color(0xfff6fdf6);
const kInputTextColor=Color(0xff83d686);
const kDefaultPadding=20.0;
const kDefaultHeight=20.0;
const kDefaultWidth=20.0;
const kDefaultPosition=20.0;

const String kText='Enter any Medical Condition or a Disease that you have,for which you are searching for a Specialist.Please try to use the correct Medical Term to explain your Disease.(you can add more than one disease)' ;

final authController=AuthController.authGetter;
final roleController = RoleController.roleGetter;
final prefController=Preferences.preferencesGetter;
final appController=AppController.appGetter;
final firestoreHelper=FirestoreHelper.firestoreGetter;
final userProfileController=UserProfileController.userProfileController;





