import 'dart:convert';
import 'package:get/get.dart';
import 'package:patient_assistant/components/custom_circle_progress_indicator.dart';
import 'package:patient_assistant/components/custom_dialog_box.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../controllers/role_controller.dart';
import 'dart:io';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final roleController=RoleController.roleGetter;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        leading: IconButton(icon: Icon(Icons.add),onPressed: (){
        }),
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
