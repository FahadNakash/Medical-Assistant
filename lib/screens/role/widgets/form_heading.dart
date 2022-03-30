import 'package:flutter/material.dart';
import '../../../constant.dart';
class FormHeading extends StatelessWidget {
  final String text;
  const FormHeading({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation=MediaQuery.of(context).orientation;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('${text}:',style: Theme.of(context).textTheme.bodyText2!.copyWith( fontSize: 15,fontWeight: FontWeight.bold),),
        Expanded(child: Divider(color: kTextColor,)),

      ],
    );
  }
}
