import 'package:flutter/material.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/controllers/auth_controller.dart';
import 'package:patient_assistant/models/user.dart';
import 'package:patient_assistant/screens/auth/widgets/login_form.dart';
import '../widgets/signup_form.dart';
import 'package:animations/animations.dart' as ani;
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
    final authControlle=AuthController.authGetter;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20),
      constraints: BoxConstraints(
        maxWidth: 500,
        minWidth: 300
      ),
      child: Column(
        children: [
          FormType(isLogin: isLogin,),
          SizedBox(height: kDefaultHeight*2,),
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxWidth: 500,minWidth: 350),
              //height: (orientation==Orientation.portrait)?size.height*0.8:900,
                child: animatedAuthForms()),
          ),
          Container(
            height: (orientation==Orientation.portrait)?size.height*0.10:50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isLogin?'Need an Account?':'Already have an Account',style: TextStyle(fontSize: 10,color: kTextColor),),
              AppButton(
                  textSize: 10,defaultLinearGradient: false,
                  height: 20,
                  width: 80,
                  onPressed: (){
                isLogin=!isLogin;
                authControlle.emailErr=null;
                authControlle.passErr=null;
                authControlle.email='';
                authControlle.password='';
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
  duration: Duration(milliseconds: 1500),
  reverse: isLogin,
  transitionBuilder: (child,animation,secondryAnimation)=>ani.SharedAxisTransition(
    child:child,
    animation:animation,
    secondaryAnimation: secondryAnimation,
    transitionType:ani.SharedAxisTransitionType.horizontal,
  ),
  child:isLogin?LoginInForm():SignUpForm(),
);
}


class FormType extends StatelessWidget {
  bool isLogin;
   FormType({
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
          Divider(color: kTextColor,endIndent: (orientation==Orientation.portrait)?40:0,indent: (orientation==Orientation.portrait)?40:0,),
        ],
      ),
    );
  }
}
