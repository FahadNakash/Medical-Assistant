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
  TextEditingController _password=TextEditingController();
  TextEditingController _conformPassword=TextEditingController();
  bool isEyeFlag2=false;
  String conpass='';
  String? conpassErr;
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    final screenOrientation=MediaQuery.of(context).orientation;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text('Create an Account to get started',style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500
          )),
          SizedBox(height: kDefaultHeight/2,),
          //email filed
          CustomInputField(
            height: kDefaultHeight*3.5,
            label: 'Email',
            textAlign: TextAlign.center,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            errorText: authController.emailErr,
            onChanged: (value){
                authController.email=value;
                if (authController.emailErr!=null) {
                  emailValidator();
                  setState(() {
                  });
                }
            },
            onSaved: (value){
                authController.email=value!.trim();
            },
          ),
          SizedBox(height: kDefaultHeight/2,),
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
                child: Icon(Icons.remove_red_eye,color: !authController.isEyeFlag?kInputTextColor:kInputTextColor.withOpacity(0.3),)),
            textInputAction: TextInputAction.next,
            obscureText:authController.isEyeFlag,
            errorText: authController.passErr,
            onChanged: (value){
                 authController.password=value;
              if (authController.passErr!=null) {
                passwordValidator();
                setState(() {
                  authController.password=value;
                });
              }
            },
            onFieldSubmitted: (value){
              authController.password=value!.trim();
            },
          ),
          SizedBox(height: kDefaultHeight/2,),
          //confrom password field
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
                child: Icon(Icons.remove_red_eye,color: !authController.isEyeconformFlag?kInputTextColor:kInputTextColor.withOpacity(0.3),)),
              obscureText: authController.isEyeconformFlag,
              errorText: conpassErr,
              onChanged: (value){
                conpass=value;
                if (conpassErr!=null) {
                  conformpasswordValidator();
                  setState(() {});
                }},
                ),
          SizedBox(height: kDefaultHeight/2,),
          isLoading?Column(
            children: [
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
            print('1');
           FormSubmitted(authController.email,authController.password);
           setState(() {
           });
          }, text: 'SignUp'),
        ],
      ),
    );
  }

  emailValidator(){
  if ( authController.email.isEmpty) {
  authController.emailErr='Email field cannot be empty';
  }else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(authController.email)) {
  authController.emailErr='Please enter the valid email';
  }else{
   authController.emailErr=null;
  }
  }
  passwordValidator(){
    if (authController.password.isEmpty) {
      authController.passErr='Password re-enter the password';
    }else if (authController.password.length<6){
      authController.passErr='Password Must be at least 6 charactor';
    }else{
      authController.passErr=null;
    }
  }
  conformpasswordValidator(){
    if (conpass.isEmpty) {
      conpassErr='Please re-enter the password';
    }else if(_password.text !=_conformPassword.text){
      conpassErr='Password does not match';
    }else{
      conpassErr=null;
    }
  }
  Future<void> FormSubmitted(String email,String password)async{
    emailValidator();
    passwordValidator();
    conformpasswordValidator();
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email) && password.length>5 && conpassErr==null){
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
