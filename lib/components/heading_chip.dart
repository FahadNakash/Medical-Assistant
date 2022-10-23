import 'package:flutter/material.dart';

import '../constant.dart';
class HeadingChip extends StatelessWidget {
  final String title;
  const HeadingChip({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7,vertical:5),
      decoration: const BoxDecoration(
        gradient: kAppGradient,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topRight: Radius.circular(20))
      ),
      child: Text(
        title,style: kSearchChipText.copyWith(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal)
      ),
    );
  }
}
