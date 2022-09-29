import 'package:flutter/material.dart';
import 'package:patient_assistant/components/custom_circle_progress_indicator.dart';

import '../constant.dart';

class ConformDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? conform;
  final Color? conformButtonColor;
  final Color? conformTextColor;
  final Color? conformButtonBorder;
  final Color? dissmisButtonColor;
  final Color? dissmisTextColor;
  final Color? dissmisButtonBorder;

  const ConformDialogBox({Key? key, required this.title, required this.content,this.conform,this.dissmisButtonColor,this.conformButtonColor,this.conformButtonBorder,this.dissmisTextColor,this.dissmisButtonBorder,this.conformTextColor,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        title,
        style: kDialogBoxTitle,
        textAlign: TextAlign.start,
      ),
      content: Text(
        content,
        style: kDialogBoxBody,
        textAlign: TextAlign.start,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
                child: Text('Yes', style: TextStyle(color:conformTextColor??kSecondaryColor)),
                color: conformButtonColor??Colors.white,
                onPressed: conform,
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side:  BorderSide(color:conformButtonBorder??kSecondaryColor))),
            const SizedBox(
              width: kDefaultWidth / 2,
            ),
            MaterialButton(
                child:  Text('No', style: TextStyle(color:dissmisTextColor??Colors.white)),
                onPressed: () => Navigator.of(context).pop(false),
                color: dissmisButtonColor??kSecondaryColor,
                splashColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                    side:  BorderSide(color:dissmisButtonBorder??kSecondaryColor)

                )),
          ],
        )
      ],
    );
  }
}
