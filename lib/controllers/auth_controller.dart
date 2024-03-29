import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../routes/app_pages.dart';
import '../controllers/app_controller.dart';
import '../components/custom_dialog_box.dart';
import '../settings/preferences.dart';
import '../models/user_model.dart';
import '../services/firestore_helper.dart';
import '../utilities/api_exception.dart';
import '../utilities/utils.dart';

class AuthController extends GetxController {
  static AuthController get authGetter => Get.find<AuthController>();

  final prefController=Preferences.preferencesGetter;
  final appController=AppController.appGetter;
  final firestoreController=FirestoreHelper.firestoreGetter;

  String email = '';
  String? emailErr;
  String password = '';
  String? passErr;
  bool isEyeFlag = true;
  bool isEyeconformFlag = true;
  String login = 'logging in»';
  late Rx<User?> user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
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

  Future<void> createNewAccount(String email, String password, void Function(void Function() fn) setState) async {
    try {
      bool isConnection = await InternetConnectionChecker().hasConnection;
     if (isConnection){
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
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

  Future<void> logIn(String email, String password, void Function(void Function() fn) setState) async{
    try {
      bool _isCheck = await InternetConnectionChecker().hasConnection;
      if (_isCheck) {
        final response=await _auth.signInWithEmailAndPassword(email: email, password: password);
        setState((){
          login='fetching data»»';
        });
        UserModel _fireStoreData=await firestoreController.getCloudData(response.user!.uid);
        UserModel _getLocalData=prefController.getUserSession();

        if (_fireStoreData.uid.isEmpty && _getLocalData.uid.isEmpty) {
          Get.dialog(CustomDialogBox(
            title: 'Alert !',
            middleText: 'No user data was found in the app or cloud storage.You have to proceed o Form Screen to enter details',
            onPressed: () {
              Get.toNamed(Routes.role);
            },));
        }else {
          final _imageName = Utils().getNameFromUrl(_fireStoreData.imageUrl);
          await Utils().storeImageLocally(url: _fireStoreData.imageUrl, imageName: _imageName);
          // final _getImagePath = await Utils().getImageLocally(_fireStoreData.uid);
          final _getImageFile = await Utils().getImageFileLocally(_fireStoreData.uid);

          prefController.saveUserSession(_fireStoreData);
          appController.user = _fireStoreData;
          // appController.user.imagePath = _getImagePath!;
          appController.user.imageFile = _getImageFile!;
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
    }catch (e){
      ApiException(e.toString());
    }
  }



}
