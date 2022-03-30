import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_assistant/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
class RoleController extends GetxController{
 static RoleController get roleGetter=>Get.find<RoleController>();
 Rx<File>? image;
 var selectImage=''.obs;

 Future<void> getImage(ImageSource source)async{
  try {
   final galleryStatus=await Permission.storage.status;
   final cameraStatus=await Permission.camera.status;
   if (!galleryStatus.isGranted && !cameraStatus.isGranted) {
     await Permission.storage.request();
     await Permission.camera.request();
   }
   if (await Permission.storage.isGranted) {
     print('run 1');
     final pickImage=await ImagePicker.platform.getImage(source: source);
     print('run 2');
     print(pickImage);
    if (pickImage!=null) {
      print('run 3');
      File? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickImage.path,
          aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
         ],
         androidUiSettings: AndroidUiSettings(
             toolbarTitle: 'Cropper',
             toolbarColor: kPrimaryColor,
             toolbarWidgetColor: Colors.white,
             initAspectRatio: CropAspectRatioPreset.original,
             lockAspectRatio: false),
         iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
         )
     );
      print('run 4');
      //image=Rx(File(croppedFile!.path));
      selectImage.value=croppedFile!.path;
      print('run 5');
      print(selectImage.value);
      print('run 6');
    }
   }
  }on PlatformException catch(e){
  }
 }




}