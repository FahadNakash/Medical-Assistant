import 'package:flutter/material.dart';

import 'package:patient_assistant/constant.dart';
class DayChip extends StatelessWidget {
  final String day;
  final VoidCallback onTap;
  final bool isSelected;

  const DayChip({Key? key,required this.day,required this.onTap,this.isSelected=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
      height: 50,
      width: 40,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border:Border.all(color: isSelected?kPrimaryColor:kGrey),
          gradient: isSelected?kAppGradient:null
      ),
      child: Center(child: Text(day,style:  TextStyle(color:isSelected?Colors.white:Colors.black87,fontSize: 14,fontWeight: FontWeight.w400))),
    ),
    );
  }
}

