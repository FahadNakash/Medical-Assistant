import 'package:flutter/material.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/screens/auth/widgets/login_form.dart';
import '../../constant.dart';
import '../auth/widgets/auth_forms.dart';
import '../auth/widgets/logo_text_appbar.dart';
class  AuthScreen extends StatelessWidget {
  const  AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final screenOrientation=MediaQuery.of(context).orientation;
    // print(MediaQuery.of(context).viewInsets.top); all points
    // print(MediaQuery.of(context).viewInsets.vertical);
    // print(MediaQuery.of(context).viewPadding.top); pnly top
    // print(MediaQuery.of(context).viewPadding.vertical);  top and bottom
    return Scaffold(
      body:SafeArea(
        child: Container(
          height: size.height,
          child: SingleChildScrollView(
            physics: (screenOrientation==Orientation.portrait)?NeverScrollableScrollPhysics():null,
            child: Container(
              height: size.height,
              child: Column(
                children: [
                  TextLogoAppBar(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
