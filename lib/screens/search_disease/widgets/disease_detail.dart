import 'package:flutter/material.dart';

import '../../../components/heading_chip.dart';
import '../../../constant.dart';
import '../../../models/disease.dart';
class DiseaseDetail extends StatelessWidget {
  final Disease disease;
  const DiseaseDetail({Key? key,required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailText(),
              _diseaseCategories(),
              _diseaseInfo()

            ],
          ),
        ));
  }
  Widget _detailText(){
    return Column(
      children:  [
        Divider(color: kGrey.withOpacity(0.5),endIndent: 80,indent: 30),
        const Text('Details',style: TextStyle(color:kSecondaryColor,fontWeight: FontWeight.w100,fontFamily: 'Comfortaa',fontSize: 23)),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 30,indent: 80),
        const SizedBox(height: kDefaultHeight/2,)
      ],

    );
  }
  Widget _diseaseCategories(){
    final List<String> _categories=disease.diseaseCat.split(',');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingChip(title: 'Disease Category:'),
        const SizedBox(height: kDefaultHeight),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            spacing: 10,
            children:_categories.map((e) => _categoriesChip(e)).toList(),
          ),
        ),
        const SizedBox(height: kDefaultHeight),
      ],
    );
  }
  Widget _categoriesChip(String text){
    return InkWell(
      splashColor: kblue,
      highlightColor: Colors.white,
      onTap: () {
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 30,
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding / 3, horizontal: kDefaultPadding / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: kblue.withOpacity(0.7)),
        ),
        child: Text(text,
            style: const TextStyle(color: kblue, fontSize: 12)),
      ),
    );
  }
  Widget _diseaseInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const HeadingChip(title: 'Disease Info: '),
        const SizedBox(height: kDefaultHeight),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(disease.diseaseInfo,style: kBodyText,),
        ),
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),

      ],
    );
  }

}
