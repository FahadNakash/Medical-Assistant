import 'dart:io';

import 'package:flutter/material.dart';
import 'package:patient_assistant/utilities/utils.dart';

import '../../database/firebase.dart';
import '../../controllers/app_controller.dart';
class UserProfile extends StatefulWidget{

   UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;
  final appController=AppController.appGetter;
  File? file;
  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userProfile'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.eighteen_mp))
        ],
      ),
      body: Container(
        color: Colors.yellow,
        height: 500,
        child: (appController.imageFolderPath.isEmpty)?Text('null'):Image.file(File(appController.imageFolderPath)),
      ),
    );
  }
}
