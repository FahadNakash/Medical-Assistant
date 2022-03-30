import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
class CustomCircleProgressIndicator extends StatelessWidget {
  const CustomCircleProgressIndicator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: kPrimaryColor,
      strokeWidth: 2,
    );
  }
}
