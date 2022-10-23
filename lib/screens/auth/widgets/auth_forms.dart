import 'package:flutter/material.dart';
import 'package:animations/animations.dart' as ani;


import '../../../components/app_button.dart';
import '../../../controllers/auth_controller.dart';
import 'package:patient_assistant/screens/auth/widgets/login_form.dart';
import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';
import '../../../constant.dart';

class AuthForms extends StatefulWidget {

  const AuthForms({Key? key,}) : super(key: key);
  @override
  _AuthFormsState createState() => _AuthFormsState();
}
class _AuthFormsState extends State<AuthForms> {
bool isLogin=true;
@override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final orientation=MediaQuery.of(context).orientation;
    final authController=AuthController.authGetter;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      constraints: const BoxConstraints(
        maxWidth: 500,
        minWidth: 300
      ),
      child: Column(
        children: [
          FormType(isLogin: isLogin,),
          const SizedBox(height: kDefaultHeight*2,),
          Expanded(
            child: Container(
              color: Colors.white,
              constraints: const BoxConstraints(maxWidth: 500,minWidth: 350),
                child: animatedAuthForms()),
          ),
          SizedBox(
            height: (orientation==Orientation.portrait)?size.height*0.10:50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLogin?'Need an Account?':'Already have an Account',style: const TextStyle(fontSize: 10,color: kGrey),),
              AppButton(
                  textSize: 10,defaultLinearGradient: false,
                  height: 20,
                  width: 80,
                  onPressed: (){
                isLogin=!isLogin;
                authController.emailErr=null;
                authController.passErr=null;
                authController.email='';
                authController.password='';
                setState(() {
                });
              }, text: isLogin?'SignUp':'LogIn')
            ],
          ),
          )
        ],
      ),
    );
  }
Widget animatedAuthForms()=>ani.PageTransitionSwitcher(
  duration: const Duration(milliseconds: 1500),
  reverse: isLogin,
  transitionBuilder: (child,animation,secondryAnimation)=>ani.SharedAxisTransition(
    child:child,
    fillColor: Colors.white,
    animation:animation,
    secondaryAnimation: secondryAnimation,
    transitionType:ani.SharedAxisTransitionType.horizontal,
  ),
  child:isLogin?const LoginInForm():const SignUpForm(),
);
}


class FormType extends StatelessWidget {
  final bool isLogin;
   const FormType({
    Key? key,
    required this.isLogin
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orientation=MediaQuery.of(context).orientation;
    return Container(
      color: Colors.white,
      height: kDefaultHeight*3,
      child: Column(
        children: [
          Text(isLogin?'Login':'Sign Up',style: Theme.of(context).textTheme.headline5),
          Divider(color: kGrey,endIndent: (orientation==Orientation.portrait)?40:0,indent: (orientation==Orientation.portrait)?40:0,),
        ],
      ),
    );
  }
}
