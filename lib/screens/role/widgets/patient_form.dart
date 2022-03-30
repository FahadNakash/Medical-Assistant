import 'package:flutter/material.dart';
import '../../../components/custom_input_field.dart';
import '../../../constant.dart';
import '../widgets/form_heading.dart';
class PatientForm extends StatelessWidget {
  const PatientForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation=MediaQuery.of(context).orientation;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaulPadding,),
      child: Column(
        children: [
          FormHeading(text: 'Basic Info'),
          SizedBox(height: kDefaulPadding/2),
          CustomInputField(label: 'Name',helperText: 'Enter your full name'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomInputField(label: 'Country',fieldwidth:(orientation==Orientation.portrait)?150:250,suffixIcon: InkWell(child: Icon(Icons.arrow_drop_down_outlined))),
              CustomInputField(label: 'City',fieldwidth:(orientation==Orientation.portrait)?150:250,)
            ],
          ),
        ],
      ),
    );
  }
}
