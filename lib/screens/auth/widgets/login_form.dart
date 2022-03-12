import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/constant.dart';
class LoginInForm extends StatefulWidget {
  const LoginInForm({Key? key}) : super(key: key);
  @override
  State<LoginInForm> createState() => _LoginInFormState();
}
class _LoginInFormState extends State<LoginInForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Login',style: Theme.of(context).textTheme.headline5!.copyWith(
            color: kPrimaryColor,
            fontSize: 30
          ),),
          // Divider(color: kTextColor,endIndent: 40,indent: 40,),
          Text('Login into your account to get started',style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: kHeadingColor
          ),),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
            child: TextFormField(
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: kInputTextColor)),
                  focusColor: kInputTextColor,
                  //border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Colors.yellow)),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: kInputTextColor.withOpacity(0.2))),
                  filled: true,
                  fillColor: kInputTextColor.withOpacity(0.1),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: kErrorColor)),
                  hintStyle: TextStyle(color: kInputTextColor,fontFamily: 'Comfortaa'),
                label: Text('Email',style: TextStyle(color: kPrimaryColor),
                )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
            child: TextFormField(
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                  focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)),borderSide: BorderSide(color: kInputTextColor)),
                  focusColor: kInputTextColor,
                  //border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: Colors.yellow)),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: kInputTextColor.withOpacity(0.2))),
                  filled: true,
                  fillColor: kInputTextColor.withOpacity(0.1),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide(color: kErrorColor)),
                  hintStyle: TextStyle(color: kInputTextColor,fontFamily: 'Comfortaa'),
                label: Text('Password',style: TextStyle(color: kPrimaryColor),
                )
              ),
            ),
          ),
          AppButton(height: 40, width: 90, onPressend: (){}, text: 'Login'),
        ],
      ),
    );
  }
}
