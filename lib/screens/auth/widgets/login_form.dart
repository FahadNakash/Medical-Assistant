import '../../../controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_input_field.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/constant.dart';
class LoginInForm extends StatefulWidget {
  const LoginInForm({Key? key}) : super(key: key);
  @override
  State<LoginInForm> createState() => _LoginInFormState();
}
class _LoginInFormState extends State<LoginInForm> {
  final authController=AuthController.authGetter;
  bool _isloading=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text('Login into your account to get started',style: Theme.of(context).textTheme.headline5!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w800
          )),
          SizedBox(height: kDefaulPadding,),
          CustomInputField(
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            errorText: authController.emailErr,
            onChanged: (value){
              authController.email=value;
              if (authController.emailErr!=null) {
                emailValidation();
                setState(() {
                });
              }
            },
            onSaved: (value){
              authController.email=value!.trim();
            },
          ),
          SizedBox(height: kDefaulPadding,),
          CustomInputField(
            label: 'Password',
            suffixIcon: InkWell(
                onTap: (){
                  setState(() {
                    authController.isEyeFlag=!authController.isEyeFlag;
                  });
                },
                child: Icon(Icons.remove_red_eye,color: !authController.isEyeFlag?kPrimaryColor:kPrimaryColor.withOpacity(0.3),)),
            textInputAction: TextInputAction.next,
            obscureText:authController.isEyeFlag,
            errorText: authController.passErr,
            onChanged: (value){
              authController.password=value;
              if (authController.passErr!=null) {
                passwordValidation();
                setState(() {
                });
              }
            },
            onFieldSubmitted: (value){
              authController.password=value!.trim();
            },
          ),
          SizedBox(height: kDefaulPadding,),
          _isloading?CircularProgressIndicator(color: kPrimaryColor,):AppButton(
            textSize: 15,
            defaulLinearGridient: true,
              height: 35,
              width: 100,
              onPressed:()async{
            setState(() {
              _isloading=true;
            });
            await submitForm(authController.email, authController.password);

            // await Future.delayed(Duration(seconds: 3),(){});
            print('complete');
            setState(() {
              _isloading=false;
            });
          }, text: 'Login'),
        ],
      ),
    );
  }
  Future<void> submitForm(String email,String password)async{
    emailValidation();
    passwordValidation();
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) && password.length>5){
      print(email);
      print(password);
      authController.logIn(email, password,setState);

    }
  }
emailValidation(){
    if (authController.email.isEmpty){
     authController.emailErr='please enter the email';
    }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(authController.email)){
      authController.emailErr='Please enter the correct email';
    }else{
      authController.emailErr=null;
    }
}
passwordValidation(){
    if (authController.password.isEmpty){
     authController.passErr='Please enter the password';
    }else if (authController.password.length<6) {
      authController.passErr='Password must at least 6 character';
    }else{
      authController.passErr=null;
    }
}


}
