import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:patient_assistant/models/patient_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/custom_dialog_box.dart';
import '../constant.dart';
import '../controllers/app_controller.dart';
import '../models/doctor_model.dart';
import '../services/firestore_helper.dart';
import '../models/user_model.dart';
import '../routes/app_pages.dart';
import '../settings/preferences.dart';
import '../utilities/utils.dart';
import 'auth_controller.dart';
import '../services/storage_helper.dart';

class RoleController extends GetxController {
  static RoleController   get roleGetter => Get.find<RoleController>();

  final authController = AuthController.authGetter;
  final appController=AppController.appGetter;
  final prefsController=Preferences.preferencesGetter;
  final firestoreController=FirestoreHelper.firestoreGetter;

  FirebaseFirestore cloudFireStore = FirebaseFirestore.instance;

  var selectImage = ''.obs;



  Future<void> getImage(ImageSource source) async {
    try {
      final galleryStatus = await Permission.storage.status;
      final cameraStatus = await Permission.camera.status;
      if (!galleryStatus.isGranted  ) {
        await Permission.storage.request();
      }else if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }
      if (await Permission.storage.isGranted || await Permission.camera.isGranted) {
        // ignore: invalid_use_of_visible_for_testing_member
        final pickImage = await ImagePicker.platform.getImage(source: source,imageQuality: 20,maxHeight: 880,maxWidth: 790,);
        if (pickImage != null) {
          File? croppedFile = await ImageCropper().cropImage(
            sourcePath: pickImage.path,
            cropStyle: CropStyle.rectangle,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            androidUiSettings: const AndroidUiSettings(
                  backgroundColor: Colors.black,
                  statusBarColor: kPrimaryColor,
                  toolbarTitle: 'Medical Assistant Cropper',
                  toolbarColor: Colors.white,
                  toolbarWidgetColor: kPrimaryColor,
                  hideBottomControls: false,
                  activeControlsWidgetColor: kPrimaryColor,
                  cropFrameColor: kInputTextColor,
                  showCropGrid: true,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: false),
          );
          selectImage.value = croppedFile!.path;
        }
      }
    } on PlatformException catch (e) {
      Get.snackbar('Alert !', e.toString());
    }
  }

  Future<void> doctorForm({required Doctor doctor}) async {
    try {
      final isConnected=await InternetConnectionChecker().hasConnection;
      if (isConnected) {
        final _imageName=authController.currentUser.uid +'.' + selectImage.split('.').last;
        final _imageUrl=await StorageHelper.uploadProfileImage(imageName: _imageName, imageFile: File(selectImage.value));
        await Utils().storeImageLocally(url: _imageUrl,imageName: _imageName);
        final _getImagePath=await Utils().getImageLocally(authController.currentUser.uid);
        final _getImageFile=await Utils().getImageFileLocally(authController.currentUser.uid);

        UserModel user=UserModel();
        user.uid=authController.currentUser.uid;
        user.email=authController.currentUser.email!;
        user.imageUrl=_imageUrl;
        user.imageFile=_getImageFile??File('');
        user.role='Doctor';
        user.doctor=doctor;
        user.imagePath=_getImagePath!;

        appController.user=user;
        await firestoreHelper.setCloudData(user);
        await prefsController.saveUserSession(user);
        Get.offAllNamed(Routes.main_home);
      }else{
        Get.dialog(CustomDialogBox(
          title: 'something wrong',
          middleText: 'Please make sure that your device connect to internet',
          onPressed: () {
            Get.back();
          },));
      }
    } on FirebaseException catch (e) {
      Get.dialog(CustomDialogBox(
        title:'OOP\'S !' ,
        middleText:  e.toString(), onPressed: () {
        Get.back();
      },));
    } catch (e) {
      Get.dialog(CustomDialogBox(
        title:'OOP\'S !' ,
        middleText:  e.toString(), onPressed: () {
        Get.back();
      },));
    }
  }

  Future<void> patientForm({required Patient patient}) async {
    try {
      final isConnected=await InternetConnectionChecker().hasConnection;
      if (isConnected) {

        final imageName=authController.currentUser.uid +'.' + selectImage.split('.').last;
        final imageUrl=await StorageHelper.uploadProfileImage(imageName: imageName, imageFile: File(selectImage.value));
        await Utils().storeImageLocally(url: imageUrl,imageName: imageName);
        final _getImagePath=await Utils().getImageLocally(authController.currentUser.uid);

        UserModel user=UserModel();
        user.uid=authController.currentUser.uid;
        user.email=authController.currentUser.email!;
        user.imageUrl=imageUrl;
        user.imageFile=File(_getImagePath!);
        user.role='Patient';
        user.patient=patient;
        user.imagePath=_getImagePath;


        appController.user=user;
        await firestoreHelper.setCloudData(user);
        await prefsController.saveUserSession(user);
        Get.offAllNamed(Routes.main_home);
      }else{
        Get.dialog(CustomDialogBox(
          title: 'something wrong',
          middleText: 'Please make sure that your device connect to internet',
          onPressed: () {
            Get.back();
          },));
      }
    } on FirebaseException catch (e) {
      Get.dialog(CustomDialogBox(
        title:'OOP\'S !' ,
        middleText:  e.toString(), onPressed: () {
        Get.back();
      },));
    } catch (e) {
      Get.dialog(CustomDialogBox(
        title:'OOP\'S !' ,
        middleText:  e.toString(), onPressed: () {
        Get.back();
      },));
    }
  }
}
