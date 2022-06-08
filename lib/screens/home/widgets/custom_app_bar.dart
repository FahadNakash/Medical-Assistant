import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../controllers/app_controller.dart';
import '../../../utilities/utils.dart';

class CustomAppBar extends StatelessWidget {
  final appController=AppController.appGetter;
   CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Container(
      margin: EdgeInsets.only(top: kDefaultPadding,bottom: 20),
      decoration:BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: kTextColor,offset: Offset(1,1),spreadRadius: 3,blurRadius: 10),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          SizedBox(height: kDefaultHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(top: kDefaultPadding/3,right: kDefaultPadding),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: kTextColor,offset: Offset(0,-1),blurRadius: 8,),
                    ]
                ),
                child: CircleAvatar(

                  backgroundImage:FileImage(File(appController.imageFolderPath))
                ),
              ),
            ],
          ),
          SizedBox(height: kDefaultHeight*2),
          Container(
            padding: EdgeInsets.only(top: 5,left: 20),
            height: kDefaultHeight*2,
            width: width*0.7,
            decoration: BoxDecoration(
              color:kPrimaryColor,
              borderRadius: BorderRadius.only(bottomRight:Radius.circular(kDefaultPadding),topRight:Radius.circular(kDefaultPadding) ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
                child: Text('${Utils().checkGreeting()}',style:TextStyle(color:Colors.white,fontWeight: FontWeight.w400,fontSize: 25))),
          ),
          SizedBox(height: kDefaultHeight/2),
          Container(
            margin: EdgeInsets.only(left: kDefaultPadding*2),
            child: Text('${appController.user.name![0].toUpperCase()}${appController.user.name!.substring(1)}',style: TextStyle(color: kHeading2Color,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
          )

        ],
      ),
    );
  }
}
