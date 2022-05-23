import 'package:get/get.dart';

import '../controllers/role_controller.dart';

class RoleBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RoleController());
  }
}