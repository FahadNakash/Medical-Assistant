import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:patient_assistant/controllers/app_controller.dart';
import 'package:patient_assistant/screens/my_contacts/widgets/my_contacts.dart';
import '../../constant.dart';
class MyContactsScreen extends StatelessWidget {
    MyContactsScreen({Key? key}) : super(key: key);
   final appController=AppController.appGetter;

   @override
  Widget build(BuildContext context) {
     final size=MediaQuery.of(context).size;
    return Scaffold(
      body:Column(
        children: [
          customAppbar(size,context),
          MyContacts(size: size,)
        ],
      ),
    );
  }
  Widget customAppbar(Size size,context){
    bool  isPotrait=(MediaQuery.of(context).orientation==Orientation.portrait)?true:false;
    return  Container(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      height:isPotrait?size.height*0.1+40:size.height*0.3,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.white,
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_rounded,
                color: kblue,
                size: 25,
              )),
          const SizedBox(height: kDefaultHeight/2,),
          Text(appController.user.role=='Patient'?'My Doctors':'My Patient',style: const TextStyle(color: kblue,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
