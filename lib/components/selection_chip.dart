
import 'package:flutter/material.dart';

import '../constant.dart';
class SelectionChip extends StatelessWidget {
  final String label;
  final Widget? icon;
  final VoidCallback? onTap;
  const SelectionChip({Key? key,required this.label,this.icon,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:kDefaultPadding/4,vertical: kDefaultPadding/3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            kInputTextColor,
            kPrimaryColor
          ],
          begin:Alignment.topRight,
          end:Alignment.topLeft,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,style: Theme.of(context).textTheme.subtitle2),
          const SizedBox(width: kDefaultWidth/2,),
          InkWell(
            onTap:onTap,
            child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white,)),
                child: const Icon(Icons.remove,color: Colors.white,size: 12,)),
          ),
          // IconButton(onPressed: (){}, icon: Icon(Icons.add,)),
        ],
      ),
    );
  }
}
