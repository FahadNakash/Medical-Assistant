import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patient_assistant/models/doctor_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../services/firestore_helper.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/user_profile_controller.dart';
import '../profile/widgets/custom_sliver_ appbar.dart';
import '../profile/widgets/doctor_profile.dart';
import '../profile/widgets/patient_profile.dart';

class UserProfileScreen extends StatefulWidget{
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}
class _UserProfileScreenState extends State<UserProfileScreen>{

  final firestoreController=FirestoreHelper.firestoreGetter;
  final appController=AppController.appGetter;
  final userProfileController=UserProfileController.userProfileController;
  File? selectImage;
  bool _showBackButton=false;

  Future<void> pickImage(ImageSource imageSource)async{
    try{
      final galleryStatus = await Permission.storage.status;
      final cameraStatus = await Permission.camera.status;
      if (!galleryStatus.isGranted && !cameraStatus.isGranted) {
        await Permission.storage.request();
        await Permission.camera.request();
      }
      if (await Permission.storage.isGranted){
        // ignore: invalid_use_of_visible_for_testing_member
        XFile? _pickImage=await ImagePicker.platform.getImage(source: imageSource, imageQuality: 20,maxHeight: 880,maxWidth: 790);
        if (_pickImage!=null){
          await cropImage(_pickImage.path);
          setState(() {});
        }
      }
    }on PlatformException catch(e){
      if (kDebugMode) {
        print('error occurred :$e');
      }
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
    if (_cropImage!=null){
      selectImage=File(_cropImage.path);
    }
  }

    removeImage(){
    selectImage=null;
    setState(() {
    });
  }

   showButton(){
    _showBackButton=!_showBackButton;
    setState(() {});
   }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers:[
           CustomSliverAppBar(
             newSelectImage: selectImage,
             pickImage: pickImage,
             removeImage: removeImage,
             backButtonState: _showBackButton,

           ),
           SliverToBoxAdapter(
            child:appController.user.role==Doctor.role?DoctorProfile(newSelectImage: selectImage,clearNewImagePath: removeImage,enableBackButton: showButton,):PatientProfile(newSelectImage: selectImage,clearNewImagePath: removeImage,enableBackButton: showButton),
           )
        ],
      ),
    );
  }
}

