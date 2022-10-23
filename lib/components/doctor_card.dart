import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../models/user_model.dart';
import '../screens/search_specialist/search_specialist_detail_screen.dart';
import 'custom_text_button.dart';
class DoctorCard extends StatelessWidget {
  final UserModel user;
  const DoctorCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10,top: 10),
      height: kDefaultHeight * 5.5,
      child: Stack(
        children: [
          Container(
            height: kDefaultHeight * 5,
            constraints:  BoxConstraints(
              maxWidth: user.isDoctor?300:400,
            ),
            padding: const EdgeInsets.only(right: kDefaultPadding/2,top: kDefaultPadding/1.5,left: kDefaultPadding*2),
            margin: const EdgeInsets.only(left: kDefaultPadding * 3),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 7,
                      spreadRadius: 2,
                      offset: const Offset(-3, 1)),
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: const Offset(3, -1)),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(user.userName.capitalize!,style: kDoctorName,),
                      const SizedBox(height: kDefaultHeight/3,),
                      user.isDoctor
                          ?Row(
                          children:[
                            Expanded(
                                flex:4,
                                child:textChip(user.doctor.specialities[0])),
                            const SizedBox(width: kDefaultWidth/2,),
                            if (user.doctor.specialities.length>1)
                            Expanded(child:Text('+${user.doctor.specialities.length}',style: const TextStyle(color: kblue,fontSize: 13),),)]
                      )
                          :Row(
                          children: [
                            Row(children:[const Text('Patient age : ',style: kBodyText,),Text('${user.patient.age} Years',style: kBodyText.copyWith(color: kHeading1Color,fontSize: 14,fontWeight: FontWeight.bold),)],),
                            const SizedBox(width: kDefaultWidth/2,),
                          ]),
                      const SizedBox(height: kDefaultHeight/3,),
                      Text(user.userCity.capitalize!+', '+user.userCountry.capitalize!,style: Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.ellipsis,maxLines: 2)
                    ],
                  ),
                ),
                CustomTextButton(
                        text: 'Detail',
                        width: 70,
                        onTap: (){
                          Get.to(()=>const SearchedDoctorDetailScreen(),
                            arguments: {
                              'user':user.toMap(),
                              'fromChatScreen':false
                            },
                            curve: Curves.linearToEaseOut,
                            duration: const Duration(milliseconds: 600),
                          );
                        }),
              ],
            ),
          ),
          Container(
            height: kDefaultHeight * 3.5,
            margin: const EdgeInsets.only(top: 15, left: 20),
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 7,
                      spreadRadius: 2,
                      offset: const Offset(-3, 1)),
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: const Offset(3, -1)),
                ],
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(user.imageUrl),
                )),
          ),
        ],
      ),
    );

  }
  Widget textChip(String text){
    return Container(
      height: 20,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 6),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors:[
            kSecondaryColor,
            kPrimaryColor
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Text(text,style:const TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontWeight: FontWeight.w600,fontSize: 10,overflow: TextOverflow.ellipsis)),
    );
  }
}
