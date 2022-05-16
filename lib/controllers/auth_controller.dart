import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/app_pages.dart';
import '../controllers/app_controller.dart';
import '../components/custom_dialog_box.dart';
import '../services/preferences.dart';
import '../models/user.dart' as u;

//import '../routes/app_routes.dart';
class AuthController extends GetxController {
  static AuthController get authGetter => Get.find<AuthController>();
  final prefController=Preferences.preferencesGetter;
  final appController=AppController.appGetter;

  String email = '';
  String? emailErr;
  String password = '';
  String? passErr;
  bool isEyeFlag = true;
  bool isEyeconformFlag = true;
  String login = 'logging in»';
  late Rx<User?> user;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore cloudFireStore = FirebaseFirestore.instance;


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
      bool result = await InternetConnectionChecker().hasConnection;
      if (result){
        final response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        Get.offAllNamed(Routes.role);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use'){
        setState(() {
          emailErr = 'email-already-in-use';
        });
      }
    } catch (error) {
      Get.dialog(
          CustomDialogBox(
            title: 'error',
            middleText: error.toString(),
            onPressed: (){
                      Get.back();
      },));
    }
  }

  Future<void> logIn(String email, String password, void setState(void Function() fn)) async{
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result) {
        final response = await _auth.signInWithEmailAndPassword(email: email, password: password);
        setState((){
          login='fetching data»»';
        });
        final checkFormData = await cloudFireStore.collection('users').doc(response.user!.uid).get();
         print(checkFormData.data());
        if (checkFormData.data() == null) {
          Get.dialog(CustomDialogBox(
                  title: 'Alert !',
                  middleText: 'No user data was found in the app or cloud storage.You have to proceed to Form Screen to enter detail.',
                  onPressed: () {
                    Get.offNamed(Routes.role);
                  },));
        }else{
           final getData = prefController.getUserSession();
          if (getData.uid == null) {
            prefController.saveUserSession(u.User.fromJson(checkFormData.data()!));
            appController.user=u.User.fromJson(checkFormData.data()!);
            Get.toNamed(Routes.main_home);
          }else{
            Get.toNamed(Routes.main_home);
          }
        }
      }else {
        Get.dialog(CustomDialogBox(
            title: 'error',
            middleText: 'Please Make sure that your device connect to network',
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
    } catch (error){
      Get.dialog(CustomDialogBox(
        title: 'An Error Occured',
        middleText:  error.toString(),
        onPressed: () {
        Get.back();
      },));
    }
  }


}
