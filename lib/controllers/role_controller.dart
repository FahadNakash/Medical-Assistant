import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_assistant/controllers/app_controller.dart';
import 'package:patient_assistant/services/preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/custom_dialog_box.dart';
import '../constant.dart';
import '../models/user.dart';
 import 'auth_controller.dart';
import '../database/firebase.dart';
import '../controllers/app_controller.dart';
import '../services/preferences.dart';
import '../routes/app_pages.dart';

class RoleController extends GetxController {
   static RoleController   get roleGetter => Get.find<RoleController>();

   final authController = AuthController.authGetter;
  final appController=AppController.appGetter;
  final prefsController=Preferences.preferencesGetter;
   final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;

  FirebaseFirestore cloudFireStore = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

   var selectImage = ''.obs;



  Future<void> getImage(ImageSource source) async {
    try {
      final galleryStatus = await Permission.storage.status;
      final cameraStatus = await Permission.camera.status;
      if (!galleryStatus.isGranted && !cameraStatus.isGranted) {
        await Permission.storage.request();
        await Permission.camera.request();
      }
      if (await Permission.storage.isGranted) {
        final pickImage = await ImagePicker.platform.getImage(
          source: source,
          imageQuality: 20,
        );
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
              androidUiSettings: AndroidUiSettings(
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
          print(selectImage.value);
        }
      }
    } on PlatformException catch (e) {
      Get.snackbar('Alert !', e.toString());
    }
  }

  Future<void> doctorForm(
      String name,
      String country,
      String city,
      String phoneNumber,
      String practice,
      List specialities,
      String workExperience,
      String appointmentFee,
      String workplaceName,
      String workplaceAddress,
      String countryCode,
      String currency) async {
    try {
      final ref = await _storage.ref().child('user_Images').child(appController.currentUser + '.jpg');
      final UploadTask uploadTask = ref.putFile(File(selectImage.value));
      await uploadTask.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();
        User user = User(
          email: appController.currentUserEmail,
          name: name,
          imagePath: selectImage.value,
          imageUrl: imageUrl,
          appointmentFee: appointmentFee,
          city: city,
          country: country,
          experience: int.parse(workExperience),
          phoneNumber: int.parse(phoneNumber),
          practiceType: practice,
          specialities: specialities as List<String>,
          uid: appController.currentUser,
          workplaceAddress: workplaceAddress,
          workplaceName: workplaceName,
          currency: currency,
          countryCode: countryCode,
          role: 'doctor',
        );
        // final response = await cloudFireStore.collection('users').doc(authController.currentUser!.uid).set(user.toJson());
        appController.user=user;
        final sendDataCloud=cloudDbGetter.setCloudData(user, appController.currentUser);
        final storeDataLocal = await prefsController.saveUserSession(user);
        Get.offAllNamed(Routes.main_home);
      });
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

  Future<void> patientForm(String name, String country, String city, String age,List disease) async {
    try {
      final ref = await _storage.ref().child('user_Images').child(appController.currentUser + '.jpg');
      final UploadTask uploadTask = ref.putFile(File(selectImage.value));
      await uploadTask.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();
        User user = User(
          uid:appController.currentUser,
          email:appController.currentUserEmail,
          imageUrl: imageUrl,
          imagePath: selectImage.value,
          name: name,
          city: city,
          country: country,
          role: 'patient',
          patientAge: int.parse(age),
          patientDisease: disease as List<String>,
        );
        final response = await cloudFireStore.collection('users').doc(appController.currentUser).set(user.toJson());
        appController.user=user;
        final storeDataLocal = await  prefsController.saveUserSession(user);
        Get.offAllNamed(Routes.main_home);
      });
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
