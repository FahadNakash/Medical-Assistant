import 'package:flutter/material.dart';

import '../constant.dart';
import 'app_button.dart';
class CustomDialogBox extends StatelessWidget {
  final String title;
  final String middleText;
  final VoidCallback onPressed;
  const CustomDialogBox({Key? key,required this.title,required this.middleText,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(middleText),
      titleTextStyle: TextStyle(color: kHeading1Color, fontFamily: 'Comfortaa'),
      contentTextStyle: TextStyle(fontFamily: 'Comfortaa', color: kPrimaryColor),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton(
                textSize: 10,
                defaultLinearGradient: true,
                height: 50,
                width: 50,
                onPressed: onPressed,
                text: 'Ok'
            ),
          ],
        )
      ],

    );
  }
}
