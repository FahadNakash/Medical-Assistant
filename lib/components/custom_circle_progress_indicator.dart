import 'package:flutter/cupertino.dart';
import 'package:patient_assistant/constant.dart';
class CustomCircleProgressIndicator extends StatelessWidget {
  const CustomCircleProgressIndicator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      animating: true,
      color: kPrimaryColor,
      radius: 15,
    );
  }
}
