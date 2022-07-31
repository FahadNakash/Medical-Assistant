import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/app_button.dart';
import '../../controllers/app_controller.dart';
import '../../../components/custom_text_button.dart';
import '../../../providers/country_data.dart';
import '../../../providers/practice_data.dart';
import '../../../constant.dart';
import '../../models/user_model.dart';
import '../search_specialist/widgets/title_chip.dart';

class SearchedDoctorDetailScreen extends StatelessWidget {
  SearchedDoctorDetailScreen({Key? key}) : super(key: key);
  final UserModel doctor=Get.arguments;
  final appController=AppController.appGetter;

  String getDiagnose(String speciality){
    return PracticeData.practiceDescription[speciality]!;
  }

  @override
  Widget build(BuildContext context){
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(size),
              doctorDetail(size,context),
            ],
          ),
        ),
      ),
    );
  }


  Widget customAppBar(Size size){
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: kDefaultPadding,bottom: 30),
          width: size.width,
          height: size.height*0.30,
          decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(80)),
              gradient: LinearGradient(
                colors: [
                  Colors.lightGreen.withAlpha(190),
                  const Color(0xff329D9C).withAlpha(190)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             IconButton(onPressed: (){ Get.back(); }, icon:const Icon(Icons.arrow_back,color: kHeading2Color,)),
              Row(
                children: [
                  Container(
                    height: kDefaultHeight*5,
                    width: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black38, offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1)
                        ],
                        image:  DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(doctor.imageUrl),
                        )
                    ),
                  ),
                 const SizedBox(width: kDefaultWidth/2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr ${doctor.doctor.name.capitalize}',style: const TextStyle(color: kHeading2Color,fontFamily: 'Montserrat',fontSize: 20,fontWeight: FontWeight.bold),),
                      const SizedBox(height:kDefaultHeight/3,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 4),
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xff8BC6EC),
                              Color(0xff9599E2)

                            ]
                          )
                        ),
                        child: Text('Over ${doctor.doctor.experience} years of Experience',style: const TextStyle(color: Colors.white,fontFamily:'Montserrat',fontSize: 13,fontWeight: FontWeight.w600 ),),
                      )
                    ],
                  )

                ],
              )
            ],
          )
        ),
      ],
    );
  }
  Widget doctorDetail(Size size,BuildContext context){
    return Container(
      margin: const EdgeInsets.only(top: kDefaultPadding*2),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleChip(title:(doctor.doctor.specialities.length==1)?doctor.doctor.specialities[0]:'Specialities' ),
          const SizedBox(height: kDefaultHeight),
          (doctor.doctor.specialities.length==1)?
          Container(
            margin: const EdgeInsets.only(right: 5),
            padding: const EdgeInsets.only(left: kDefaultPadding,),
            child: Text(getDiagnose( doctor.doctor.specialities[0]),style:  TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 14,)),
          ):
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2+10),
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              alignment: WrapAlignment.center,
              children: chipsButton(),
            ),
          ),
          const SizedBox(height: kDefaultHeight),
          const TitleChip(title: 'WorkPlace'),
          const SizedBox(height: kDefaultHeight),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   SizedBox(
                     height: 70,
                     width: size.width*0.6+10,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(doctor.doctor.workplaceName.capitalize!,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold,fontSize: 18,),maxLines: 2),
                         const SizedBox(height: kDefaultHeight/4),
                         Text(doctor.doctor.workplaceAddress.capitalize!+','+doctor.doctor.country.capitalize!,style: Theme.of(context).textTheme.subtitle1,maxLines: 2),
                       ],
                     ),
                   ),
                   const Spacer(),
                   CustomTextButton(text: 'Direction',onTap: (){},width: 70,)
                 ],
               ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding*2,vertical: kDefaultPadding/2),
                  child: Column(
                    children: [
                      Row(
                        children:  [
                          Text('Appointment fee :',style: Theme.of(context).textTheme.subtitle1,),
                          const SizedBox(width: kDefaultWidth/2),
                          Text(doctor.doctor.appointmentFee +' '+ CountryData.countryInfo[doctor.doctor.country]![1][0],style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: kDefaultHeight/3),
                      Row(
                        children:  [
                          Text('Phone number :',style: Theme.of(context).textTheme.subtitle1,),
                          const SizedBox(width: kDefaultWidth/2),
                          Text('+${CountryData.countryInfo[doctor.doctor.country]![0]}'+doctor.doctor.phoneNumber,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: kDefaultHeight/3),
                      Divider(color: kTextColor.withOpacity(0.5),),
                    ],
                  ),
                ),
                if (appController.user.role=='Patient')
                  GetBuilder<AppController>(
                      builder: (controller) =>controller.addedDoctorsList.contains(doctor)
                      ?AppButton(
                      height: 45,
                      width: 140,
                      onPressed: (){},
                      text: 'Message' ,
                      textSize: 15,
                      defaultLinearGradient: true)
                      :Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextButton(
                          onTap: (){
                            controller.addDoctor(doctor);
                            Get.snackbar('Confirmation ', 'Doctor Add Successfully',duration: const Duration(milliseconds: 1500),colorText: Colors.white,backgroundColor: kPrimaryColor,snackPosition: SnackPosition.BOTTOM);
                          },
                          text: 'Add to My Doctor',
                          fontSize: 12,
                          width: 140,height: 45,borderRadius: 40),
                      AppButton(
                          height: 45,
                          width: 140,
                          onPressed: (){},
                          text: 'Message' ,
                          textSize: 15,
                          defaultLinearGradient: true)
                    ],)
                  )
              ],
            ),
          )
        ],
      ),

    );
  }

  List<Widget> chipsButton(){
    final List<Widget>_chipsButtons=[];
    for (var speciality in doctor.doctor.specialities) {
      _chipsButtons.add(
        InkWell(
          splashColor: kHeading2Color,
          highlightColor: Colors.white,
          onTap: (){
           Get.dialog(diagnoseDialogueBox(speciality));
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 30,
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding/3,horizontal: kDefaultPadding/2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kHeading2Color.withOpacity(0.7)),
            ),
            child: Text(speciality,style: const TextStyle(color: kHeading2Color,fontSize: 12)
            ),
          ),
        )
      );
    }
    return _chipsButtons;
  }
  Widget diagnoseDialogueBox(String speciality){
    return AlertDialog(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding:const EdgeInsets.all(kDefaultPadding),
      title:  Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
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
              child: Text(speciality,style:const TextStyle(color: Colors.white,fontFamily: 'Montserrat',fontWeight: FontWeight.w600,fontSize: 12)),
            ),
          ),
          const SizedBox(width: 5,),
          Flexible(fit: FlexFit.loose,child: Divider(color: kTextColor.withOpacity(0.5))),
          InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.white,
            onTap: (){Get.back();},
            child: Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
              decoration:  BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors:[
                    Colors.red,
                    Colors.red.shade200,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: const Icon(Icons.close,color: Colors.white,size: 15),
            ),
          ),
        ],
      ),
      content: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.only(left: kDefaultPadding,),
        child: Text(getDiagnose(speciality),style:  kBodyText),
      ),
    );
  }




}
