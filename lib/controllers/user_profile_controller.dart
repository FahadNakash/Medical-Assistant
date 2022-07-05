import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/models/doctor_model.dart';
import 'package:patient_assistant/models/patient_model.dart';
import 'package:patient_assistant/utilities/utils.dart';

import '../components/custom_dialog_box.dart';
import '../controllers/app_controller.dart';
import '../services/firestore_helper.dart';
import '../services/storage_helper.dart';
import '../models/user_model.dart';
import '../providers/country_data.dart';


class UserProfileController extends GetxController{
  static UserProfileController userProfileController=Get.find<UserProfileController>();

  final cloudDbGetter=FirestoreHelper.firestoreGetter;
  final _appController=AppController.appGetter;

  final countryInfo=CountryData.countryInfo;

  Future<void> updateDoctorProfile({required Doctor doctor,required File? newImage,required File oldImage})async{
    try{
      final _isConnected=await InternetConnectionChecker().hasConnection;
      if (_isConnected){
        final _imageUrl=await updateImage(newImage, oldImage);
        final _getImagePath=await Utils().getImageLocally(_appController.user.uid);
        final _getImageFile=await Utils().getImageFileLocally(_appController.user.uid);

        UserModel user=UserModel();
        user.uid=_appController.user.uid;
        user.imageUrl=_imageUrl;
        user.imagePath=_getImagePath!;
        user.imageFile=_getImageFile!;
        user.email=_appController.user.email;
        user.role=Doctor.role;
        user.doctor=doctor;

        _appController.user=user;
        await firestoreHelper.setCloudData(user);
        await prefController.saveUserSession(user);
        AppController.appGetter.update();

      }else{
        Get.dialog(CustomDialogBox(
          title: 'something wrong',
          middleText: 'Please make sure that your device connect to internet',
          onPressed: () {
            Get.back();
          },));
      }
    }on FirebaseException catch(e){
      Get.dialog(CustomDialogBox(
        title: 'something wrong',
        middleText: e.toString(),
        onPressed: () {
          Get.back();
        },));
    }catch(e){
      Get.dialog(CustomDialogBox(
        title: 'something wrong',
        middleText: '$e',
        onPressed: () {
          Get.back();
        },));
    }

  }

  Future<void> updatePatientProfile({required Patient patient,required File? newImage,required File oldImage})async{
    try{
      final isConnected=await InternetConnectionChecker().hasConnection;
      if (isConnected){
        final _imageUrl=await updateImage(newImage, oldImage);
        final _getImagePath=await Utils().getImageLocally(_appController.user.uid);
        final _getImageFile=await Utils().getImageFileLocally(_appController.user.uid);

        UserModel user=UserModel();
        user.uid=_appController.user.uid;
        user.imageUrl=_imageUrl;
        user.imagePath=_getImagePath!;
        user.imageFile=_getImageFile!;
        user.email=_appController.user.email;
        user.role=Patient.role;
        user.patient=patient;

        _appController.user=user;
        await firestoreHelper.setCloudData(user);
        await prefController.saveUserSession(user);
        AppController.appGetter.update();

        //String imageName=_appController.user.uid! +'.'+imageFile!.path.split('.').last;
        // String imageUrl=await StorageHelper.uploadProfileImage(imageName: imageName, imageFile: imageFile);
        // User editUser=User(
        //   name: patientName,
        //   patientAge: patientAge,
        //   country: patientCountry,
        //   city: patientCity,
        //   patientDisease: patientDiseases
        // );
      }else{
        Get.dialog(CustomDialogBox(
          title: 'something wrong',
          middleText: 'Please make sure that your device connect to internet',
          onPressed: () {
            Get.back();
          },));
      }
    }on FirebaseException catch(e){
      Get.dialog(CustomDialogBox(
        title:'OOP\'S !' ,
        middleText:  e.toString(), onPressed: () {
        Get.back();
      },));
    }catch(e){
      Get.dialog(CustomDialogBox(
        title:'OOP\'S !' ,
        middleText:  e.toString(), onPressed: () {
        Get.back();
      },));
    }

  }


  Future<String> updateImage(File? _newImage,File _oldImage)async{
    if (_newImage!=null) {
      String _imageName=_appController.user.uid +'.'+_newImage.path.split('.').last;
      final _imageUrl=await StorageHelper.uploadProfileImage(imageName: _imageName, imageFile: _newImage);
      bool _isFileExist=await _oldImage.exists();
       if (_isFileExist) {
         _oldImage.deleteSync();
         _appController.user.imagePath='';
         await Utils().storeImageLocally(url:_imageUrl, imageName: _imageName);
       }
      return _imageUrl;
    }
    else{
      return _appController.user.imageUrl;
    }
  }





  }




