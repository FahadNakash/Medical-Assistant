import 'package:flutter/material.dart';
import 'package:patient_assistant/controllers/auth_controller.dart';
import '../../controllers/role_controller.dart';
import '../role/widgets/image_picker_container.dart';
import '../role/widgets/role_selector.dart';
class RoleScreen extends StatelessWidget {
    RoleScreen({Key? key,}) : super(key: key);
  final authController=AuthController.authGetter;
  final roleController=RoleController.roleGetter;
  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          clipBehavior: Clip.hardEdge,
          primary: false,
          child: Column(
            children: [
              // portrait 30% and landscape 50%
              ImagePickerContainer(),
              const RoleSelector(),
            ],
          ),
        ),
      ),
    );
  }



}
