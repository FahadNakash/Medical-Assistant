
import 'package:flutter/material.dart';

import 'package:patient_assistant/constant.dart';

class CustomFilterChip extends StatefulWidget {
  final String label;
  final Function() onTap;
  final bool selectChip;
   const CustomFilterChip({
    Key? key,
    required this.label,
     required this.onTap,
     required this.selectChip,
  }) : super(key: key);

  @override
  State<CustomFilterChip> createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(50),
        splashColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding/2),
          decoration:  BoxDecoration(
              border: Border.all(color: kGrey.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              gradient: widget.selectChip?const LinearGradient(
                colors: [
                  kInputTextColor,
                  kPrimaryColor
                ],
                begin:Alignment.topRight,
                end:Alignment.topLeft,
              ):null
          ),
          child: Text(widget.label,style: TextStyle(fontSize: 10,color: widget.selectChip?Colors.white:kGrey)),
        ),
      ) ;
  }
}






