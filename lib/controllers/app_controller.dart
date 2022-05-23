import 'package:get/get.dart';

import '../models/user.dart';
import '../controllers/auth_controller.dart';

class AppController extends GetxController{
 static AppController get appGetter=>Get.put(AppController());
 String currentUser='';
 String currentUserEmail='';
User user=User();

}