import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../models/drug.dart';
import '../../../models/drug_interaction_model.dart';
import '../../../utilities/utils.dart';
import 'categories_dialog.dart';
import '../../../components/heading_chip.dart';

class DrugDetail extends StatefulWidget {
  final Drug drugInfo;
  final DrugInteraction drugInteract;
    const DrugDetail({Key? key,required this.drugInfo,required this.drugInteract}) : super(key: key);

  @override
  State<DrugDetail> createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
   bool _isShowMore=true;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _detailText(),
          _categories(),
          _usedFor(),
          _instructions(),
          _work(),
          _sideEffect(),
          _drugInteractions(),
        ],
      ),
    );
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

  Widget _categories(){
    return Column(
      children: [
        Row(
          children:  [
            const HeadingChip(title: 'Pregnancy Category\t:'),
            const SizedBox(width: 5),
            GestureDetector(onTap: (){Get.dialog(const CategoriesDialog());},child: const Icon(Icons.info_outline,size: 20,color: kSecondaryColor)),
            Expanded(child: Text("\"${widget.drugInfo.pregnancyCategory??'"NA"'}\"",style: kSearchHeading3.copyWith(fontWeight: FontWeight.normal),textAlign: TextAlign.center)),
        ],),
        const SizedBox(height: kDefaultHeight),
        Row(
          children:  [
            const HeadingChip(title: 'Lactation Category\t:'),
            const SizedBox(width: 5),
            GestureDetector(onTap: (){Get.dialog(const CategoriesDialog());},child: const Icon(Icons.info_outline,size: 20,color: kSecondaryColor)),
            Expanded(child: Text("\"${widget.drugInfo.lactationCategory??'"NA"'}\"",style: kSearchHeading3.copyWith(fontWeight: FontWeight.normal),textAlign: TextAlign.center)),
          ],),
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),
      ],
    );
  }

  Widget _usedFor(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const HeadingChip(title: 'Used For :'),
        const SizedBox(height: kDefaultHeight),
        Padding(padding:const EdgeInsets.symmetric(horizontal: 10),child: Text('${widget.drugInfo.usedFor}.',style: kBodyText,)),
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),

      ],
    );
  }

  Widget _instructions(){
    final List<Widget> _instruction=[];
    final List<String> _instructionsList=Utils.removeAllHtmlTags(widget.drugInfo.instructions);
    for(int i=0;i<_instructionsList.length-1;i++){
      _instruction.add(Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text('• ${_instructionsList[i]}.',style:kBodyText)));
    }
    return widget.drugInfo.instructions.isEmpty
        ?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const HeadingChip(title: 'Instructions :'),
        const SizedBox(height: kDefaultHeight),
        Center(child: Text('"NA"',style: kSearchHeading3.copyWith(fontWeight: FontWeight.normal),textAlign: TextAlign.center)),
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),
      ],
    )
        :Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingChip(title: 'Instructions :'),
        const SizedBox(height: kDefaultHeight),
        ..._instruction,
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),
      ],
    );
  }

  Widget _work(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingChip(title: 'How is Works :'),
        const SizedBox(height: kDefaultHeight),
        widget.drugInfo.howItWorks.isNotEmpty
            ?Padding(padding:const EdgeInsets.symmetric(horizontal: 10),child: Text('${widget.drugInfo.howItWorks.trim()}.',style: kBodyText,))
            :  Center(child: Text('"NA"',style:  kSearchHeading3.copyWith(fontWeight: FontWeight.normal),textAlign: TextAlign.center)),
    const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),
      ],
    );
  }

  Widget _sideEffect(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadingChip(title: 'Side Effects :'),
        const SizedBox(height: kDefaultHeight),
        widget.drugInfo.sideEffects.isEmpty
            ? Center(child: Text('"NA"',style:  kSearchHeading3.copyWith(fontWeight: FontWeight.normal),textAlign: TextAlign.center))
            :Padding(padding:const EdgeInsets.symmetric(horizontal: 10),child: Text('${widget.drugInfo.sideEffects.trim()}.',style: kBodyText,)),
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),
      ],
    );
  }

  Widget _drugInteractions(){
    final List<Widget> _drugInteractions=[];
    if (widget.drugInteract.interactions.isNotEmpty) {
      for(int i=0;_isShowMore?i<10:i<widget.drugInteract.interactions.length;i++){
        _drugInteractions.add(Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text('${i+1}) ${widget.drugInteract.interactions[i].description}',style: kBodyText,)));
      }
    }
    return widget.drugInteract.interactions.isEmpty
        ?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:  [
            const HeadingChip(title: 'Drug Interactions : '),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                        colors: [
                          // Color(0xff7b4397),
                          // Color(0xffdc2430)
                          Color(0xffEE0979),
                          Color(0xffFF6A00),
                        ]
                    )
                ),
                child: const Text('Total 0 found',style: TextStyle(fontSize: 10,color: Colors.white),))

          ],
        ),
        const SizedBox(height: kDefaultHeight),
        Center(child: Text('"NA"',style:  kSearchHeading3.copyWith(fontWeight: FontWeight.normal),textAlign: TextAlign.center)),
        const SizedBox(height: kDefaultHeight),
        Divider(color: kGrey.withOpacity(0.5),endIndent: 50,indent: 30),
        const SizedBox(height: kDefaultHeight),
      ],
    )
        :Column(
      children:[
        Row(
          children:  [
            const HeadingChip(title: 'Drug Interactions : '),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffEE0979),
                    Color(0xffFF6A00)
                  ]
                )
              ),
                child: Text('Total ${widget.drugInteract.interactions.length} found',style: const TextStyle(fontSize: 10,color: Colors.white),))

          ],
        ),
        const SizedBox(height: kDefaultHeight),
        ..._drugInteractions,
        const SizedBox(height: kDefaultHeight),
        _showMoreButton(),
        const SizedBox(height: kDefaultHeight),

      ],
    );
  }

  Widget _showMoreButton(){
    return InkWell(
      onTap: (){
        _isShowMore=!_isShowMore;
        setState(() {
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                colors:[
                  Color(0xff578BA3),
                  Color(0xff4CB9BE),
                ]
            )
        ),
        child: Text(_isShowMore?'Show All':'Show Less',style: const TextStyle(
            color: Colors.white,
            fontSize: 15
        )),
      ),
    );
  }

}
