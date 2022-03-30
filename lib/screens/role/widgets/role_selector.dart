import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_assistant/constant.dart';
import '../widgets/doctor_form.dart';
import '../widgets/patient_form.dart';
import '../widgets/role_selector_button.dart';
class RoleSelector extends StatefulWidget {
   RoleSelector({Key? key,}) : super(key: key);
  @override
  _RoleSelectorState createState() => _RoleSelectorState();
}
class _RoleSelectorState extends State<RoleSelector> {
  bool _isDoctor=true;
  bool _isPatient=false;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          SizedBox(height: kDefaulPadding,),
          //role Selector Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                splashColor: Colors.white,
                onTap: (){
                  _isPatient=false;
                  _isDoctor=true;
                  setState(() {
                  });
                },
                child: RoleSelectorButton(
                  icon: Icon(FontAwesomeIcons.userDoctor,size: 40,color:_isDoctor?Colors.white:kTextColor),
                  text: 'Doctor',
                  isSelect: _isDoctor,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                splashColor: Colors.white,
                onTap: (){
                  setState(() {
                    _isDoctor=false;
                    _isPatient=true;
                  });
                },
                child: RoleSelectorButton(
                  icon: Icon(FontAwesomeIcons.userInjured,size: 40,color: _isPatient?Colors.white:kTextColor,),
                  text: 'Patient', isSelect:_isPatient,
                ),
              ),
            ],
          ),
          //current form
          SizedBox(height: kDefaulPadding,),
          Container(
              height: size.height,
              child: currentFormTransition())


        ],
      ),
    );
  }
  Widget currentFormTransition(){
    return PageTransitionSwitcher(
      duration: Duration(milliseconds: 1500),
      reverse: _isDoctor,
      transitionBuilder: (child,animation,secondaryAnimation)=>SharedAxisTransition(
          child: child,
          fillColor: Colors.white,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal),
      child:_isDoctor?DoctorForm():PatientForm(),
    );


  }
}


