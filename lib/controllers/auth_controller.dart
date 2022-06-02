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
import '../utilities/api_exception.dart';
import '../utilities/utils.dart';


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


  User get currentUser {
    return user.value!;
  }

  @override
  void onReady() {
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    super.onReady();
  }

  Future<void> createNewAccount(String email, String password, void setState(void Function() fn)) async {
    try {
      bool isConnection = await InternetConnectionChecker().hasConnection;
     if (isConnection){
        final response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
        u.User _cloudData=await cloudDbGetter.getCloudData(response.user!.uid);
        u.User _getData = prefController.getUserSession();
           if (_getData.uid == null) {
             prefController.saveUserSession(_cloudData);
             appController.user=_cloudData;
             appController.imageFolderPath=(await Utils().getImageLocally())!;
             Get.toNamed(Routes.main_home);
           }else{
             appController.imageFolderPath=(await Utils().getImageLocally())!;
             appController.user=_cloudData;
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

  Future<void> signOut()async{
    await _auth.signOut();
    await prefController.removeUserSession();
    appController.user=u.User();
  }


}
