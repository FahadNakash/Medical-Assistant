import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../constant.dart';
import '../../../controllers/app_controller.dart';
import '../../../utilities/utils.dart';

class CustomAppBar extends StatelessWidget {
  final appController=AppController.appGetter;
   CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return  Container(
      margin: const EdgeInsets.only(top: kDefaultPadding,bottom: 20),
      decoration:const BoxDecoration(
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
          const SizedBox(height: kDefaultHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: kDefaultPadding/3,right: kDefaultPadding),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: kTextColor,offset: Offset(0,-1),blurRadius: 8,),
                    ]
                ),
                child: GetBuilder<AppController>(
                  builder: (context) {
                    return Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder:MemoryImage(kTransparentImage),
                          image: MemoryImage(appController.user.imageFile.readAsBytesSync()) ,
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultHeight*2),
          Container(
            padding: const EdgeInsets.only(top: 5,left: 20),
            height: kDefaultHeight*2,
            width: width*0.7,
            decoration: const BoxDecoration(
              color:kPrimaryColor,
              borderRadius: BorderRadius.only(bottomRight:Radius.circular(kDefaultPadding),topRight:Radius.circular(kDefaultPadding) ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
                child: Text(Utils().checkGreeting(),style:const TextStyle(color:Colors.white,fontWeight: FontWeight.w400,fontSize: 25)
                )
            ),
          ),
          const SizedBox(height: kDefaultHeight/2),
          Container(
            margin: const EdgeInsets.only(left: kDefaultPadding*2),
            child: GetBuilder<AppController>(
              builder: (context) {
                return Text('${appController.user.userName[0].toUpperCase()}${appController.user.userName.substring(1)}',
                style: const TextStyle(color: kHeading2Color,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic));
              }
            ),
          )

        ],
      ),
    );
  }
}
