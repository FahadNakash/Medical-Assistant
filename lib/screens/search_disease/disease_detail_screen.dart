import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../../models/disease.dart';
import 'widgets/disease_detail.dart';

class DiseaseDetailScreen extends StatelessWidget {
  DiseaseDetailScreen({Key? key}) : super(key: key);
  final Disease _disease=Get.arguments['disease'];

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _customAppbar(),
             DiseaseDetail(disease: _disease,)


          ],
        ),
      ),
    );
  }
  Widget _customAppbar(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: (){ Get.back();}, icon: const Icon(Icons.arrow_back_rounded,color: kblue,)),
        Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_disease.diseaseName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
        ))
      ],
    );
  }



}
