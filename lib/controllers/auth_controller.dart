import 'dart:io';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/app_pages.dart';
import '../controllers/app_controller.dart';
import '../components/custom_dialog_box.dart';
import '../services/preferences.dart';
import '../models/user.dart' as u;
import '../database/firebase.dart';
import '../utils/api_exception.dart';

//import '../routes/app_routes.dart';
class AuthController extends GetxController {
  static AuthController get authGetter => Get.find<AuthController>();
  final prefController=Preferences.preferencesGetter;
  final appController=AppController.appGetter;
  final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;

  String email = '';
  String? emailErr;
  String password = '';
  String? passErr;
  bool isEyeFlag = true;
  bool isEyeconformFlag = true;
  String login = 'logging in»';
  late Rx<User?> user;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore cloudFireStore=FirebaseFirestore.instance;


  User? get currentUser {
    return user.value;
  }

  @override
  void onReady() {
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    super.onReady();
  }

  Future<void> createNewAccount(String email, String password, void setState(void Function() fn)) async {
    try {
      bool isResult = await InternetConnectionChecker().hasConnection;
     if (isResult){
        final response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        appController.currentUser=response.user!.uid;
        appController.currentUserEmail=response.user!.email!;
       Get.offAllNamed(Routes.role);
      }else{
        Get.dialog(
            CustomDialogBox(
              title: 'Something wrong',
              middleText: 'Please make sure that your device is connect to internet',
              onPressed: (){
                Get.back();
              },));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use'){
        setState(() {
          emailErr = 'email-already-in-use';
        });
      }
    } on SocketException catch(e){
      Get.dialog(
          CustomDialogBox(
            title: 'error',
            middleText: e.toString(),
            onPressed: (){
              Get.back();
            },));
    }catch (e) {
      Get.dialog(
          CustomDialogBox(
            title: 'error',
            middleText: e.toString(),
            onPressed: (){
                      Get.back();
      },));
    }
  }

  Future<void> logIn(String email, String password, void setState(void Function() fn)) async{
    try {
      bool isResult = await InternetConnectionChecker().hasConnection;
      if (isResult) {
        final response = await _auth.signInWithEmailAndPassword(email: email, password: password);
        setState((){
          login='fetching data»»';
        });
        appController.currentUser=response.user!.uid;
        appController.currentUserEmail=response.user!.email!;
        u.User cloudData=await cloudDbGetter.getCloudData(appController.currentUser);
        u.User getData = prefController.getUserSession();
           if (getData.uid == null) {
             prefController.saveUserSession(cloudData);
             appController.user=cloudData;
             Get.toNamed(Routes.main_home);
           }else{
             appController.user=cloudData;
             Get.toNamed(Routes.main_home);
           }
      }else {
        Get.dialog(CustomDialogBox(
            title: 'something wrong',
            middleText: 'Please make sure that your device connect to internet',
            onPressed: () {
              Get.back();
            },));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'wrong-password') {
        setState(() {
          passErr = error.message;
        });
      } else if (error.code == 'user-not-found') {
        setState(() {
          emailErr = error.message;
        });
      }
    }on ApiException catch(e){
      Get.dialog(CustomDialogBox(
        title: 'Alert !',
        middleText:  e.toString(),
        onPressed: () {
          Get.offAllNamed(Routes.role);
        },));
    }catch (error){
      Get.dialog(CustomDialogBox(
        title: 'An Error Occurred',
        middleText:  error.toString(),
        onPressed: () {
        Get.back();
      },));
    }
  }


}
