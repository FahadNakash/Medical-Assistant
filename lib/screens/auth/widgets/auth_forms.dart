import 'package:flutter/material.dart';
import 'package:patient_assistant/components/app_button.dart';
import 'package:patient_assistant/screens/auth/widgets/login_form.dart';
class AuthForms extends StatefulWidget {
  const AuthForms({Key? key}) : super(key: key);
  @override
  _AuthFormsState createState() => _AuthFormsState();
}
class _AuthFormsState extends State<AuthForms> {
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    final orientation=MediaQuery.of(context).orientation;
    return Column(
      children: [
        Container(color: Colors.yellow,height: 400,),
        Container(
      color: Colors.blue,
      child: Row(
        children: [
          Text('Need an Account'),
          AppButton(height: 30, width: 95, onPressend: (){}, text: 'Sign Up')
        ],
      ),
    )

      ],
    );
  }
}
