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
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthController extends GetxController{
  static AuthController get authGetter=>Get.find<AuthController>();
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore cloudFireStore=FirebaseFirestore.instance;
  String  email='';
  String? emailErr;
  String password='';
  String? passErr;
  bool isEyeFlag=true;
  bool isEyeconformFlag=true;
  Rx<String> login='***logging in***'.obs;
  late Rx<User?> user;
  String get userid{
    return user.value!.uid;
  }

  //@override
  // void onReady() {
  //   user=Rx<User?>(auth.currentUser);
  //   user.bindStream(auth.userChanges());
  //   ever(user,initialPage);
  // }
  // initialPage(User? user){
  //   if (user!=null) {
  //     //homePage
  //   }else{
  //     //loginScreen
  //   }
  // }

  Future<void> createNewAccount(String email,String password,void setState(void Function() fn))async{
    // SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    try{
      bool result=await InternetConnectionChecker().hasConnection;
      if (result==true) {
        final response=await auth.createUserWithEmailAndPassword(email: email, password: password);
        //final authUser=AuthUser(uid: response.user!.uid,email: response.user!.email!,formid: null);
        //print(authUser);
        //final prefuid=sharedPreferences.setString('userData', json.encode(authUser));
        // print(prefuid);
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
          titleStyle:TextStyle(color: kHeading1Color,fontFamily: 'Comfortaa'),
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

  Future<void> logIn(String email,String password,void setState(void Function() fn))async{
    try{
      bool result=await InternetConnectionChecker().hasConnection;
      if (result==true) {
       await Future.delayed(Duration(seconds: 3),(){
          login.value='***Loading User***';
        });
        final  response=await auth.signInWithEmailAndPassword(email: email, password: password);
        Get.toNamed('/role_screen');
         final checkFormData=await cloudFireStore.collection('users').doc('WohanGoYBPsS3fSP3tSx').get();
        // final formdata=await checkFormData.data();
        // print(formdata?['name']);
        // await userData(response: response);
      }else{
        Get.defaultDialog(
            title: 'error',
            middleText: 'Please Make sure that your device connect to network',
            titleStyle:TextStyle(color: kHeading1Color,fontFamily: 'Comfortaa'),
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
          titleStyle:TextStyle(color: kHeading1Color,fontFamily: 'Comfortaa'),
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
  // Future<void> userData({required UserCredential response})async{
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   await Future.delayed(Duration(seconds: 3),(){
  //     login.value='***Fetching data***';
  //   });
  //   final checkUser=await prefs.getString('userData');
  //   if (checkUser!=null) {
  //     final user=json.decode(checkUser);
  //   }else{
  //     Get.defaultDialog(
  //         title: 'Alert',
  //         middleText: 'Please Fill the form then you will enter the home screen',
  //         titleStyle:TextStyle(color: kHeading1Color,fontFamily: 'Comfortaa'),
  //         middleTextStyle: TextStyle(fontFamily: 'Comfortaa',color: kPrimaryColor),
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               AppButton(textSize: 10,defaulLinearGridient: true,height: 50, width: 50, onPressed:(){
  //                 Get.back();
  //                 //Get.toNamed('/role_screen');
  //               },
  //                   text: 'Ok'),
  //             ],
  //           )
  //         ]);
  //     print(response.user!.email);
  //     print(response.user!.uid);
  //     final authUser=AuthUser(uid: response.user!.uid,email: response.user!.email!,formid: null);
  //     //final prefuid=prefs.setString('userData', json.encode(authUser));
  //     //print(prefuid);
  //     print('userData not found in locally');
  //     Get.to(RoleScreen());
  //   }
  //
  // }











}