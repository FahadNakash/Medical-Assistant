import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../routes/app_pages.dart';
import '../../../models/doctor_model.dart';
import '../../../constant.dart';
import '../../../models/user_model.dart';
import '../../../controllers/app_controller.dart';

class ContactTile extends StatelessWidget {
  final UserModel user;
  final String? chatId;
   ContactTile({Key? key,required this.user,required this.chatId}) : super(key: key);
  final appController=AppController.appGetter;

  @override
  Widget build(BuildContext context){
    return InkWell(
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: (){
        Get.toNamed(Routes.chat,
            arguments:{
          'chatId':chatId,
          'user':user.toMap()
        }
        );
      },
      child: ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder: MemoryImage(kTransparentImage),
              image:  NetworkImage(user.imageUrl),
            ),
          ),
        ),
        title: Text(appController.user.role==Doctor.role?user.userName:'Dr.${user.userName}',style: kDoctorName),
        subtitle:const Divider(endIndent: 20),
      ),
    );
  }
}