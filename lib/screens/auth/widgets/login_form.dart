import '../../../components/custom_circle_progress_indicator.dart';
import '../../../../models/user.dart';
import '../../../controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_input_field.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/constant.dart';
import 'package:get/get.dart';

class LoginInForm extends StatefulWidget {
  const LoginInForm({Key? key}) : super(key: key);
  @override
  State<LoginInForm> createState() => _LoginInFormState();
}
class _LoginInFormState extends State<LoginInForm> {
  final authController = AuthController.authGetter;
  bool _isloading = false;

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text('Login into your account to get started',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 15,
                  )),
          SizedBox(
            height: kDefaultHeight,
          ),
          CustomInputField(
            height: kDefaultHeight*3.5,
            label: 'Email',
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            errorText: authController.emailErr,
            onChanged: (value) {
              authController.email = value.trim();
              if (authController.email.isEmpty){
                authController.emailErr='This field cannot be left empty';
                setState(() {
                });
              }else if (authController.emailErr != null) {
                emailValidation();
                setState(() {});
              }
            },
          ),
          SizedBox(
            height: kDefaultHeight,
          ),
          CustomInputField(
            height: kDefaultHeight*3.5,
            label: 'Password',
            textAlign: TextAlign.center,
            suffix: InkWell(
                onTap: () {
                  setState(() {
                    authController.isEyeFlag = !authController.isEyeFlag;
                  });
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: !authController.isEyeFlag
                      ?authController.passErr==null?kInputTextColor:kErrorColor
                      :authController.passErr==null?kInputTextColor.withOpacity(0.3):kErrorColor.withOpacity(0.3),
                )),
            textInputAction: TextInputAction.next,
            obscureText: authController.isEyeFlag,
            errorText: authController.passErr,
            onChanged: (value) {
              authController.password = value;
              if (authController.password.isEmpty) {
                authController.passErr='This field cannot be left empty';
                setState(() {
                });
              }else if (authController.passErr!= null) {
                passwordValidation();
                setState(() {});
              }
            },
          ),
          SizedBox(
            height: kDefaultHeight,
          ),
          _isloading
              ? Column(
                  children: [
                    CustomCircleProgressIndicator(),
                    SizedBox(
                      height: kDefaultHeight/2,
                    ),
                    Obx(()=>Text('${authController.login}',style: TextStyle(fontSize: 10),))
                  ],
                )
              : AppButton(
                  textSize: 15,
                  defaultLinearGradient: true,
                  height: (kDefaultHeight*2),
                  width: kDefaultWidth*5,
                  onPressed: () async {
                    setState(() {
                      _isloading = true;
                    });
                    await submitForm(authController.email, authController.password);
                    setState(() {
                      _isloading = false;
                    });
                  },
                  text: 'Login'),
        ],
      ),
    );
  }
  Future<void> submitForm(String email, String password) async{
    emailValidation();
    passwordValidation();
    if (authController.emailErr==null && authController.passErr==null) {
      print(email);
      print(password);
     // await authController.logIn(email, password, setState,);
    }
  }
  emailValidation(){
    if (authController.email.isEmpty) {
      authController.emailErr = 'please enter the email';
    }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(authController.email)) {
      authController.emailErr = 'Please enter the correct email';
    }else if (authController.email.contains(' ')) {
      authController.emailErr = 'White-Spaces does not allow';
    }else {
      authController.emailErr = null;
    }
  }
  passwordValidation() {
    if (authController.password.isEmpty) {
      authController.passErr = 'Please enter the password';
    } else if (authController.password.length < 6) {
      authController.passErr = 'Password must at least 6 character';
    }else if(authController.password.contains(' ')){
      authController.passErr='White-Spaces does not allowed';
    }else {
      authController.passErr = null;
    }
  }
}
