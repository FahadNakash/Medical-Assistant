import 'package:flutter/material.dart';
import '../role/widgets/image_picker_container.dart';
import '../role/widgets/role_selector.dart';
class RoleScreen extends StatelessWidget {
  const RoleScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool currentPage=true;
    final size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          clipBehavior: Clip.hardEdge,
          primary: false,
          child: Column(
            children: [
              // potrait 30% and landscape 50%
              ImagePickerContainer(),
              RoleSelector(),
            ],
          ),
        ),
      ),
    );
  }



}
