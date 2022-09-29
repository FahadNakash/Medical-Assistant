import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/utilities/utils.dart';

import '../../../models/message.dart';
class MessageBubble extends StatelessWidget {
  final Message message;
  bool isMe;
  MessageBubble({required this.message,required this.isMe,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kDefaultHeight/3),
        Container(
          padding:const EdgeInsets.all(kDefaultPadding/2),
          decoration:  BoxDecoration(
            color: isMe?null:const Color(0xffF5FDFE),
            border: isMe?null:Border.all(color: kHeading2Color.withOpacity(0.2)),
            borderRadius:const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
            gradient: isMe?const LinearGradient(
                colors: [
                  kPrimaryColor,
                  kInputTextColor,
                ]
            ):null
          ),
          child:Text(message.text,style:  TextStyle(color:isMe?Colors.white:kHeading2Color,fontSize: 12)),
        ),
        const SizedBox(height: kDefaultHeight/2),
        Text(
          Utils.convertDateTime(message.createdAt),
          style: const TextStyle(
              color: kTextColor, fontSize: 10),
        ),
      ],
    );
  }
}
