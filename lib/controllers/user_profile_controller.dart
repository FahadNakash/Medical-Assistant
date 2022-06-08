import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constant.dart';
import '../controllers/app_controller.dart';
import '../database/firebase.dart';

class UserProfileController extends GetxController{
  static UserProfileController userProfileController=Get.find<UserProfileController>();

  final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;
  final appController=AppController.appGetter;

  //doctor variables;
  final RxString doctorName=''.obs;
  final RxString doctorCountry=''.obs;
  final Rx<String> doctorCityName=''.obs;
  final Rx<int> phoneNumber=0.obs;
  final RxList<String> practiceType=[''].obs;
  final RxList<String> specialities=[''].obs;
  final RxInt experience=0.obs;
  final RxInt fees=0.obs;
  final RxString workPlace=''.obs;
  final RxString workPlaceAddress=''.obs;

//patient variable
final RxString patientName=''.obs;
final RxInt age=0.obs;
final RxString patientCountry=''.obs;
final RxString cityName=''.obs;
final RxList<String> disease=[''].obs;
var selectImage = ''.obs;

  Future<void> pickImage(ImageSource imageSource)async{
    try{
      final galleryStatus = await Permission.storage.status;
      final cameraStatus = await Permission.camera.status;
      if (!galleryStatus.isGranted && !cameraStatus.isGranted) {
        await Permission.storage.request();
        await Permission.camera.request();
      }
      if (await Permission.storage.isGranted){
        XFile? _pickImage=await ImagePicker.platform.getImage(source: imageSource, imageQuality: 20,);
        if (_pickImage!=null){
          cropImage(_pickImage.path);
        }
      }
    }on PlatformException catch(e){
      print('error occured :$e');
    }

  }
  Future<void> cropImage(String imagePath)async{
    File? _cropImage=await ImageCropper().cropImage(
      sourcePath: imagePath,
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
    if (_cropImage!=null) {
     selectImage.value=_cropImage.path;
    }
  }





}