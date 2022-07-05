import 'package:flutter/material.dart';

import '../auth/widgets/auth_forms.dart';
import '../auth/widgets/logo_text_appbar.dart';

class  AuthScreen extends StatelessWidget {
  const  AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final screenOrientation=MediaQuery.of(context).orientation;
    //print('login screen data${data}');
    // print(MediaQuery.of(context).viewInsets.top); all points
    // print(MediaQuery.of(context).viewInsets.vertical);
    // print(MediaQuery.of(context).viewPadding.top); pnly top
    // print(MediaQuery.of(context).viewPadding.vertical);  top and bottom
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const TextLogoAppBar(),
              SizedBox(
                  height: (screenOrientation==Orientation.portrait)?size.height*0.82:500,
                  child: const AuthForms()
              ),

            ],
          ),
        ),
      )
    );
  }
}
