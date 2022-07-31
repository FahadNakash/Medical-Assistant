import 'package:get/get.dart';

import '../models/user_model.dart';

class AppController extends GetxController{
 static AppController get appGetter=>Get.find<AppController>();

 UserModel user=UserModel();
 final RxList<UserModel> addedDoctorsList=<UserModel>[].obs;

 addDoctor(UserModel doctor){
  if (!addedDoctorsList.contains(doctor)) {
   addedDoctorsList.add(doctor);
   update();
  }
 }




}






