import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/screens/auth/widgets/login_form.dart';
import '../widgets/signup_form.dart';
import 'package:animations/animations.dart' as ani;
class AuthForms extends StatefulWidget {
  const AuthForms({Key? key}) : super(key: key);
  @override
  _AuthFormsState createState() => _AuthFormsState();
}
class _AuthFormsState extends State<AuthForms> {
bool isLogin=true;
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
@override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final orientation=MediaQuery.of(context).orientation;
    return Column(
      children: [
        Expanded(
            child: Container(
                //color: Colors.yellow,
                child: animatedAuthForms())
        ),
        Container(
          color: Colors.purple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLogin?'Already Account':'Need an Account?'),
            AppButton(height: 30, width: 95, onPressend: (){
              isLogin=!isLogin;
              setState(() {
              });
            }, text: isLogin?'Login':'Sign Up')
          ],
        ),
        )
      ],
    );
  }
}
