import 'package:flutter/material.dart';

import 'controllers/auth_controller.dart';
import 'controllers/app_controller.dart';
import 'controllers/role_controller.dart';
import 'controllers/user_profile_controller.dart';
import 'settings/preferences.dart';
import 'services/firestore_helper.dart';
///colors
const kPrimaryColor= Color(0xff23AFB3);
const kSecondaryColor= Color(0xff1cd391);
const kErrorColor= Color(0xffe75c5c);
const kHeading1Color= Color(0xff37E87F);
const kblue=Color(0xff2d6fa2);
const kGrey=Color(0xff7b939f);
const kCream=Color(0xfff6fdf6);
const kInputTextColor=Color(0xff83d686);
const kFocusColor = Color(0xffEEEEEE);
///sizes
const kDefaultPadding=20.0;
const kDefaultHeight=20.0;
const kDefaultWidth=20.0;
const kDefaultPosition=20.0;
///strings
const String kAssets='assets/images';
const String kBaseUrl='https://healthos.co/api/v1';
const String kNoConErrMsg='Please Make Sure that your device connect to the internet';
const kAnimationDuration = Duration(milliseconds: 400);

///Gradient
const kAppGradient=LinearGradient(colors:[
  Color(0xff57D483),
  Color(0xff46AA8C)
],
  stops: [
    0.5,
    0.9
  ],
  begin:Alignment.topLeft,
  end:Alignment.topRight,);

///styles
const TextStyle kBodyText= TextStyle(color: Color(0xff3a4666),fontSize: 14,height: 1.3);
const TextStyle kErrorStyle= TextStyle(color: kErrorColor,fontSize: 14,);
const TextStyle kDialogBoxTitle =TextStyle(color: kblue,fontFamily: 'Montserrat',fontWeight: FontWeight.w800,fontSize: 20);
const TextStyle kDialogBoxBody  =TextStyle(color: kGrey,fontFamily: 'Comfortaa',fontSize: 15,height: 1.5,fontWeight: FontWeight.bold);
const TextStyle kSearchHeading1 =TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontSize: 27,fontWeight: FontWeight.w700);
const TextStyle kSearchHeading2 =TextStyle(color: kblue, fontFamily: 'Montserrat', fontSize: 20,fontWeight: FontWeight.w700);
const TextStyle kSearchHeading3 =TextStyle(color: kblue, fontFamily: 'Montserrat', fontSize: 18,fontWeight: FontWeight.w600);
const TextStyle kSearchHeading4 =TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontSize: 15,);
const TextStyle kSearchChipText =TextStyle(color: kPrimaryColor,fontFamily: 'Montserrat',fontSize: 12,fontWeight: FontWeight.w600,);
const TextStyle kDoctorName=TextStyle(color: kblue,fontFamily:'Montserrat',fontSize: 18,fontWeight: FontWeight.w600 );
///controllers
final authController=AuthController.authGetter;
final roleController = RoleController.roleGetter;
final prefController=Preferences.preferencesGetter;
final appController=AppController.appGetter;
final firestoreHelper=FirestoreHelper.firestoreGetter;
final userProfileController=UserProfileController.userProfileController;










