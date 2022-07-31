import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../components/custom_text_button.dart';
import '../../../models/user_model.dart';
import 'custom_filter_chip.dart';
import '../../../providers/country_data.dart';
import '../search_specialist_detail_screen.dart';

class DoctorDetailCard extends StatelessWidget{
  final UserModel doctorTile;
  final String country;
  final List<String> filters;
   const DoctorDetailCard({Key? key,required this.doctorTile,required this.filters,required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 110,
      decoration: BoxDecoration(
           color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow:  [
          BoxShadow(color: Colors.grey.shade200,blurRadius: 7,spreadRadius: 2,offset: const Offset(-3, 1)),
          BoxShadow(color: Colors.grey.shade200,blurRadius: 7,spreadRadius: 1,offset: const Offset(3, -1)),
        ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2,),
      child: Row(
        children: [
          Container(
            height: kDefaultHeight*4,
            width: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300,blurRadius: 7,spreadRadius: 2,offset: const Offset(-3, 1)),
                BoxShadow(color: Colors.grey.shade300,blurRadius: 7,spreadRadius: 1,offset: const Offset(3, -1)),
              ],
              image:  DecorationImage(
                fit: BoxFit.fill,
              image: NetworkImage(doctorTile.imageUrl),
              )
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/2,horizontal: kDefaultPadding/3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                   FittedBox(child: Text('Dr. ${doctorTile.doctor.name}',style:kDoctorName )),
                  const SizedBox(height: kDefaultHeight/3,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Appointment Fee ',style: Theme.of(context).textTheme.subtitle1,),
                           Row(
                             children: [
                               Text(doctorTile.doctor.appointmentFee,style: const TextStyle(color:kPrimaryColor,fontSize: 15),),
                               const SizedBox(width: 2),
                               Text('${CountryData.countryInfo[doctorTile.doctor.country]![1][0]}',style: const TextStyle(color:kPrimaryColor,fontSize: 15),),
                             ],
                           ),
                        ],
                      ),
                      const SizedBox(height: kDefaultHeight/3,),
                      Row(
                        children: [
                          Text('Result For:',style: Theme.of(context).textTheme.subtitle1,),
                          const SizedBox(width: 2),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 20,
                              width: 100,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                              decoration:  BoxDecoration(
                                  border: Border.all(color: kTextColor.withOpacity(0.2)),
                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  gradient:const LinearGradient(
                                    colors: [
                                      kSecondaryColor,
                                      kPrimaryColor
                                    ],
                                    begin:Alignment.topRight,
                                    end:Alignment.topLeft,
                                  )
                              ),
                              child:  FittedBox(child: Text(filters.isEmpty?country.isEmpty?'All Country':country:filters[0],style: const TextStyle(fontSize: 10,color:Colors.white),softWrap: true,overflow: TextOverflow.ellipsis,)),
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (filters.length>1)
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (ctx)=>_showDialogue(title: 'Selected Specialities', middleContent: filters)
                                );
                              },
                                child: Text('+${filters.length}',style: const TextStyle(color: kHeading2Color,fontSize: 13),)
                            ),
                          ),

                        ],
                      )
                    ],
                  )



                ],
              ),
            ),
          ),
           CustomTextButton(
             text: 'Detail',
               width: 50,
               onTap: (){
                 Get.to(()=>SearchedDoctorDetailScreen(),
                   arguments: doctorTile,
                   curve: Curves.linearToEaseOut,
                   duration: const Duration(milliseconds: 600),
                 );
           }),


        ],
      ),
    );

  }
  Widget _showDialogue({required String title,required List<String?> middleContent}){
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2,vertical: kDefaultPadding/3),
        height: 300,
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment:Alignment.centerRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: (){
                  //Navigator.of(context).pop();
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: kErrorColor,
                        shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.close,color: Colors.white,size: 20,)),
              ),
            ),
            const SizedBox(height: kDefaultHeight,),
            Text(title,style: const TextStyle(color: kInputTextColor,fontFamily: 'Comfortaa',fontSize: 18,fontWeight: FontWeight.bold)),
            const SizedBox(height: kDefaultHeight,),
            Expanded(
              child: Wrap(
                spacing: 7,
                runSpacing:10,
                alignment: WrapAlignment.center,
                children: middleContent.map((e) => CustomFilterChip(label: e!,onTap: (){},selectChip: true,)).toList(),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
