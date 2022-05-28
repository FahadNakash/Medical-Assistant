import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';
import 'controllers/app_controller.dart';
import 'controllers/role_controller.dart';
import 'services/preferences.dart';
import 'database/firebase.dart';

final kPrimaryColor=Color(0xff23AFB3);
final kErrorColor=Color(0xffe75c5c);
final kHeading1Color=Color(0xff37E87F);
final kHeading2Color=Color(0xff2d6fa2);
final kTextColor=Color(0xff7b939f);
final kInputBgColor=Color(0xfff6fdf6);
final kInputTextColor=Color(0xff83d686);
final kDefaultPadding=20.0;
final kDefaultHeight=20.0;
final kDefaultWidth=20.0;
final kDefaultPosition=20.0;

final String kText='Enter any Medical Condition or a Disease that you have,for which you are searching for a Specialist.Please try to use the correct Medical Term to explain your Disease.(you can add more than one disease)' ;

final authController=AuthController.authGetter;
final roleController = RoleController.roleGetter;
final prefController=Preferences.preferencesGetter;
final appController=AppController.appGetter;
final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;




