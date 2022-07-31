import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
class SelectedFilterChip extends StatelessWidget {
  final String label;


  const SelectedFilterChip({required this.label,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(label,style: kSearchChipText,),
    );
  }
}
