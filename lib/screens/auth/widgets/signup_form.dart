import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../components/app_button.dart';
import '../../../components/custom_input_field.dart';
import '../../../controllers/auth_controller.dart';
import '../../../components/custom_circle_progress_indicator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}
class _SignUpFormState extends State<SignUpForm> {
  final authController=AuthController.authGetter;
  final TextEditingController _password=TextEditingController();
  final TextEditingController _conformPassword=TextEditingController();
  bool isEyeFlag2=false;
  String conformPassword='';
  String? conformPasswordError;
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Create an Account to get started',style: Theme.of(context).textTheme.bodyText2!.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w500
        )),
        const SizedBox(height: kDefaultHeight/2,),
        //email filed
        CustomInputField(
          height: kDefaultHeight*3.5,
          label: 'Email',
          textAlign: TextAlign.center,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          errorText: authController.emailErr,
          onChanged: (value){
              authController.email=value.trim();
              if (authController.email.isEmpty) {
                authController.emailErr='This field cannot be left empty';
                setState(() {
                });
              }else if (authController.emailErr != null) {
                emailValidaton();
                setState(() {});
              }
          },
        ),
        const SizedBox(height: kDefaultHeight/2,),
       // password field
        CustomInputField(
          height: kDefaultHeight*3.5,
          controller: _password,
          label: 'Password',
          textAlign: TextAlign.center,
          helperText: 'at least 6 characters long Whitespaces not allowed',
          suffix: InkWell(
            onTap: (){
              setState(() {
                authController.isEyeFlag=!authController.isEyeFlag;
              });
            },
              child: Icon(Icons.remove_red_eye,color: !authController.isEyeFlag?authController.passErr==null?kInputTextColor:kErrorColor:authController.passErr==null?kInputTextColor.withOpacity(0.3):kErrorColor.withOpacity(0.3),)),
          textInputAction: TextInputAction.next,
          obscureText:authController.isEyeFlag,
          errorText: authController.passErr,
          onChanged: (value){
               authController.password=value.trim();
            if (authController.passErr!=null) {
              passwordValidaton();
              setState(() {
                authController.password=value;
              });
            }
          },
        ),
        const SizedBox(height: kDefaultHeight/2,),
        //conform password field
        CustomInputField(
          height: kDefaultHeight*3.5,
            controller: _conformPassword,
            label: 'Password',
          textAlign: TextAlign.center,
          helperText: 'Confirm your password',
          suffix: InkWell(
              onTap: (){
                setState(() {
                  authController.isEyeconformFlag=!authController.isEyeconformFlag;
                });
              },
              child: Icon(Icons.remove_red_eye,color: !authController.isEyeconformFlag?conformPasswordError==null?kInputTextColor:kErrorColor:conformPasswordError==null?kInputTextColor.withOpacity(0.3):kErrorColor.withOpacity(0.3),)),
            obscureText: authController.isEyeconformFlag,
            errorText: conformPasswordError,
            onChanged: (value){
              conformPassword=value.trim();
              if (conformPasswordError!=null) {
                conformpasswordValidaton();
                setState(() {});
              }},
              ),
        const SizedBox(height: kDefaultHeight/2,),
        isLoading?Column(
          children: const [
            CustomCircleProgressIndicator(),
            SizedBox(height: kDefaultHeight/4,),
            Text('..Signing Up..',style: TextStyle(fontSize: 10),),
          ],
        ):AppButton(
            textSize: 15,
            defaultLinearGradient: true,
            height: kDefaultHeight*2,
            width: kDefaultWidth*4+10,
            onPressed: ()async{
         formSubmitted(authController.email,authController.password);
         setState(() {
         });
        }, text: 'SignUp'),
      ],
    );
  }

  emailValidaton(){
  if ( authController.email.isEmpty) {
  authController.emailErr='Email field cannot be empty';
  }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(authController.email)) {
  authController.emailErr='Please enter the valid email';
  }else if (authController.email.contains(' ')) {
  authController.emailErr = 'White-Spaces does not allow';
  }else{
   authController.emailErr=null;
  }
  }
  passwordValidaton(){
    if (authController.password.isEmpty) {
      authController.passErr='Password re-enter the password';
    }else if (authController.password.length<6){
      authController.passErr='Password Must be at least 6 charactor';
    }else if (authController.password.contains(' ')){
      authController.passErr='White-Spaces does not allowed';
    } else{
      authController.passErr=null;
    }
  }
  conformpasswordValidaton(){
    if (conformPassword.isEmpty) {
      conformPasswordError='Please re-enter the password';
    }else if(_password.text !=_conformPassword.text){
      conformPasswordError='Password does not match';
    }else if (conformPassword.contains(' ')){
      conformPasswordError='White-Spaces does not allowed';
    }else{
      conformPasswordError=null;
    }
  }
  Future<void> formSubmitted(String email,String password)async{
    emailValidaton();
    passwordValidaton();
    conformpasswordValidaton();
    if (authController.emailErr==null && authController.passErr==null && conformPasswordError==null){
      setState(() {
        isLoading=true;
      });
       await authController.createNewAccount(email,password,setState);
      setState(() {
        isLoading=false;
      });
    }



  }
}
