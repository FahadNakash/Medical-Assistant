import 'package:flutter/material.dart';

import '../../../constant.dart';
class RoleSelectorButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final bool isSelect;
  const RoleSelectorButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.isSelect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 55,
      decoration: BoxDecoration(
        // color: Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          gradient:isSelect?LinearGradient(
            colors: [
              const Color(0xff8360c3).withOpacity(0.5),
              const Color(0xff2ebf91).withOpacity(0.7),

            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ):null,
          border: Border.all(color: kGrey.withOpacity(0.5)
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(text,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color:isSelect?Colors.white:Colors.grey ),)
        ],
      ),
    );
  }
}