import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_assistant/routes/app_pages.dart';

import '../../../constant.dart';
import '../../../models/disease.dart';
class DiseaseTile extends StatelessWidget {
  final Disease disease;
  const DiseaseTile({Key? key,required this.disease,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      key: UniqueKey(),
      data: ThemeData(
          splashColor:Colors.white,
          highlightColor: Colors.white
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2,),
        shape:RoundedRectangleBorder(side: BorderSide(width: 1,color:kPrimaryColor.withOpacity(0.1)),borderRadius: BorderRadius.circular(15)),
        title: Text(disease.diseaseName,style: TextStyle(color: kHeading1Color.withOpacity(0.8),fontSize: 12,fontFamily: 'Comfortaa')),
        subtitle: Text('Disease Id: ${disease.diseaseId}',style: const TextStyle(color: Colors.black54,fontSize: 10,fontFamily: 'Comfortaa')),
        trailing:RotatedBox(quarterTurns: 1,child: SizedBox(child: Icon(Icons.double_arrow_sharp,color:kHeading1Color.withOpacity(0.5),))),
        onTap: (){
          Get.toNamed(Routes.disease_detail,arguments: {'disease':disease});
        },
      ),
    );
  }
}

