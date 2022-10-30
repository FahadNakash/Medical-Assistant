import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../../models/drug.dart';
import '../../models/drug_interaction_model.dart';
import '../../utilities/utils.dart';
import '../search_drug/widget/drug_detail.dart';

class DrugDetailScreen extends StatelessWidget {
  DrugDetailScreen({Key? key}) : super(key: key);
  final Drug _drugInfo=Drug.fromJson(Get.arguments['drug_info']);
  final DrugInteraction _drugInteract=DrugInteraction.fromJson(Get.arguments['drug_interact']);


  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: [
            _customAppbar(),
            DrugDetail(drugInfo: _drugInfo, drugInteract: _drugInteract)

          ],
        )
      ),
    );
  }

  Widget _customAppbar(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(onPressed: (){ Get.back();}, icon: const Icon(Icons.arrow_back_rounded,color: kblue,)),
        Center(child: Text(Utils.removeSpecialChar(_drugInfo.name),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),textAlign: TextAlign.center,))
      ],
    );
  }

}
