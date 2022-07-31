import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_assistant/controllers/app_controller.dart';

import '../../controllers/my_doctor_or_patient_controller.dart';
import '../../constant.dart';
class MyContactsScreen extends StatelessWidget {
    MyContactsScreen({Key? key}) : super(key: key);
   final appController=AppController.appGetter;

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(splashColor: Colors.white,highlightColor: Colors.white,onTap: (){Get.back();},child: const Icon(Icons.arrow_back_rounded,color: kHeading2Color),),
      ),
      body:ListView.separated(
        separatorBuilder: (context,index)=>const Divider(),
        itemCount: appController.addedDoctorsList.length,
        itemBuilder:(context,index)=>Container(
          color: Colors.green,
          height: 100,

        ),

      ),
    );
  }
}
