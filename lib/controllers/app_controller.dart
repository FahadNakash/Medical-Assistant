import 'package:get/get.dart';

import '../models/user.dart';
class AppController extends GetxController{
 static AppController get appGetter=>Get.put(AppController());

 User user=User();

 late String imageFolderPath='';




}