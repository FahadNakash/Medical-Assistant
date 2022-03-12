import 'package:flutter/material.dart';
import '../../../constant.dart';
import '../../../components/app_button.dart';
class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenOrientation=MediaQuery.of(context).orientation;
    return Form(
      child: Column(
        children: [
          Text('Sign Up',style: Theme.of(context).textTheme.headline5!.copyWith(
              color: kPrimaryColor,
              fontSize: 30
          ),),
          Divider(color: kTextColor,endIndent: 40,indent: 40,),
          SizedBox(height: kDefaulPadding*2,),
          Text('Create an Account to get started',style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
          AppButton(height: 50, width: 120, onPressend: (){}, text: 'SignUp')

        ],
      ),
    );
  }
}
