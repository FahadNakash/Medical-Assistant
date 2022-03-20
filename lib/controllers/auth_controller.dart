import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/models/auth_user.dart';
import '../components/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/role/role_screen.dart';
class AuthController extends GetxController{
  static AuthController get authGetter=>Get.find<AuthController>();
  FirebaseAuth auth=FirebaseAuth.instance;
  String  email='';
  String? emailErr;
  String password='';
  String? passErr;
  bool isEyeFlag=true;
  bool isEyeconformFlag=true;
  late Rx<User?> user;
  @override
  void onReady() {
    user=Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user,initialPage);
  }
  initialPage(User? user){
    if (user!=null) {
      //homePage
    }else{
      //loginScreen
    }
  }

  Future<void> createNewAccount(String email,String password,void setState(void Function() fn))async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    try{
      bool result=await InternetConnectionChecker().hasConnection;
      if (result==true) {
        final response=await auth.createUserWithEmailAndPassword(email: email, password: password);
        final authUser=AuthUser(uid: response.user!.uid,email: response.user!.email!);
        print(authUser);
        final prefuid=sharedPreferences.setString('userData', json.encode(authUser));
        print(prefuid);
        Get.toNamed('/role_screen');
        // final prefemail=sharedPreferences.setString('email',authUSer.email);
      }
  }on FirebaseAuthException catch(error){
      if (error.code=='email-already-in-use') {
        setState((){
          emailErr='email-already-in-use';
        });
      }
    }catch(error){
      Get.defaultDialog(
          title: 'error',
          middleText: error.toString(),
          titleStyle:TextStyle(color: kHeadingColor,fontFamily: 'Comfortaa'),
          middleTextStyle: TextStyle(fontFamily: 'Comfortaa',color: kPrimaryColor),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton( textSize: 10,defaulLinearGridient: true,height: 50, width: 50, onPressed:(){
                  Get.back();
                },
                    text: 'Ok'),
              ],
            )
          ]);
  }}

  Future<void> logIn(String email,String password,void setState(void Function() fn))async {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    try{
      bool result=await InternetConnectionChecker().hasConnection;
      if (result==true) {
        final response=await auth.signInWithEmailAndPassword(email: email, password: password);
        final userData=sharedPreferences.getString('userData');
        final decodeData=json.decode(userData!);
        if (decodeData['uid']!=null) {

        }
        print(decodeData['uid']);
      }else{
        Get.defaultDialog(
            title: 'error',
            middleText: 'Please Make sure that your device connect to network',
            titleStyle:TextStyle(color: kHeadingColor,fontFamily: 'Comfortaa'),
            middleTextStyle: TextStyle(fontFamily: 'Comfortaa',color: kPrimaryColor),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(textSize: 10,defaulLinearGridient: true,height: 50, width: 50, onPressed:(){
                    Get.back();
                  },
                      text: 'Ok'),
                ],
              )
            ]);

      }
  }on FirebaseAuthException catch(error){
      if (error.code=='wrong-password') {
        setState((){passErr=error.message;});
      }else if (error.code=='user-not-found') {
        setState((){emailErr=error.message;});
      }
    }catch(error){
      Get.defaultDialog(
          title: 'An Error Occured',
          middleText: error.toString(),
          titleStyle:TextStyle(color: kHeadingColor,fontFamily: 'Comfortaa'),
          middleTextStyle: TextStyle(fontFamily: 'Comfortaa',color: kPrimaryColor),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(textSize: 10,defaulLinearGridient: true,height: 50, width: 50, onPressed:(){
                  Get.back();
                },
                    text: 'Ok'),
              ],
            )
          ]);
  }
  }











}