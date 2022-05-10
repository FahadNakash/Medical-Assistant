import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_assistant/components/custom_dialog_box.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/models/user.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/app_button.dart';
import 'auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class RoleController extends GetxController {
  static RoleController get roleGetter => Get.find<RoleController>();
  final authController = AuthController.authGetter;
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
      final _sharedPreferences = await SharedPreferences.getInstance();
      final ref = await _storage
          .ref()
          .child('user_Images')
          .child(authController.currentUser!.uid + '.jpg');
      final UploadTask uploadTask = ref.putFile(File(selectImage.value));
      await uploadTask.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();
        Map<String, dynamic> userData = User(
          email: authController.currentUser!.email,
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
          uid: authController.currentUser!.uid,
          workplaceAddress: workplaceAddress,
          workplaceName: workplaceName,
          currency: currency,
          countryCode: countryCode,
          role: 'doctor',
        ).toJson();
        final response = await cloudFireStore
            .collection('users')
            .doc(authController.currentUser!.uid)
            .set(userData);
        final storeDataLocal = await _sharedPreferences.setString(
            'userData', json.encode(userData));
        Get.toNamed('/home_screen');
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
      final _sharedPreferences = await SharedPreferences.getInstance();
      final ref = await _storage
          .ref()
          .child('user_Images')
          .child(authController.currentUser!.uid + '.jpg');
      final UploadTask uploadTask = ref.putFile(File(selectImage.value));
      await uploadTask.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();
        Map<String, dynamic> userData = User(
          uid: authController.currentUser!.uid,
          email: authController.currentUser!.email,
          imageUrl: imageUrl,
          imagePath: selectImage.value,
          name: name,
          city: city,
          country: country,
          role: 'patient',
          patientAge: int.parse(age),
          patientDisease: disease as List<String>,
        ).toJson();
        final response = await cloudFireStore
            .collection('users')
            .doc(authController.currentUser!.uid)
            .set(userData);
        final storeDataLocal = await _sharedPreferences.setString(
            'userData', json.encode(userData));
        Get.offAllNamed('/home_screen');
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
