import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:patient_assistant/components/custom_circle_progress_indicator.dart';
import 'package:patient_assistant/components/my_icons_icons.dart';
import 'package:patient_assistant/components/side_drawer.dart';
import 'package:patient_assistant/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/role_controller.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/preferences.dart';

import '../../routes/app_pages.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final authController = AuthController.authGetter;
  final appController=AppController.appGetter;
  final prefController=Preferences.preferencesGetter;
  Future<Map<String,dynamic>?> getDataFromLocal()async{
    final _sharedPreferences= await SharedPreferences.getInstance();
    final getData=await _sharedPreferences.getString('userData');
    if (getData!=null) {
      final convertData=json.decode(getData);
      return convertData;
    }
    return null;

}

  @override
  Widget build(BuildContext context){
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
  //  print(authController.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('press'),
        actions: [
          IconButton(onPressed: ()async{
            FirebaseAuth _auth = FirebaseAuth.instance;
              final response=await _auth.signOut();
             await prefController.removeUserSession();

              Get.offNamed(Routes.auth);

          }, icon: Icon(MyIcons.logout))
        ],
      ),
      body: FutureBuilder<Map<String,dynamic>?>(
        future: getDataFromLocal(),
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CustomCircleProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('opps something wrong');
          }
          if (snapshot.hasData) {
            final userData=snapshot.data;
            final imagePath=userData!['imagePath'];
            return Container(
              child: Image.file(File(imagePath)),
            );
          }
          return Text('opps something wrong');
        }
      ),

    );
  }
}
