import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';

import '../widgets/screen_options.dart';
class HomeCategories extends StatelessWidget {
  const HomeCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/4),
      child: Column(
        children: [
          SizedBox(height: kDefaultHeight,),
          ScreenOptions(),
        ],
      ),
    );
  }
}
