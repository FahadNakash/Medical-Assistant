import 'package:flutter/material.dart';
import '../../../constant.dart';
import '../../../components/app_button.dart';
class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenOrientation=MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      physics: (screenOrientation==Orientation.portrait)?NeverScrollableScrollPhysics():null,
      child: Container(
        child: Form(
          child: Column(
            children: [
              Text('Sign Up',style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: kPrimaryColor,
                  fontSize: 30
              ),),
              Divider(color: kTextColor,endIndent: 40,indent: 40,),
              SizedBox(height: kDefaulPadding*2,),
              Text('Login into your account to get started',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: kHeadingColor
              ),),
              TextFormField(
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                    focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    filled: true,
                    fillColor: kInputTextColor.withOpacity(0.7),
                    hintStyle: TextStyle(color: kInputTextColor,fontFamily: 'Comfortaa'),
                    border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                    label: Text('Email',style: TextStyle(color: kInputTextColor),
                    )
                ),
              ),
              TextFormField(),
              AppButton(height: 50, width: 120, onPressend: (){}, text: 'SignUp')

            ],
          ),
        ),
      ),
    );
  }
}
