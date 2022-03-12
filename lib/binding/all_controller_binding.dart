import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
class AllControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());

  }
}