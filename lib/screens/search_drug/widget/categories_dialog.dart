import 'package:flutter/material.dart';

import '../../../components/heading_chip.dart';
import '../../../constant.dart';
import '../../../providers/practice_data.dart';

class CategoriesDialog extends StatelessWidget {
  const CategoriesDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: const BorderSide(color: kPrimaryColor)),
      content: ListView.separated(
          separatorBuilder:  (context,index)=>const SizedBox(),
          itemBuilder: (context,index)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingChip(title: PracticeData.drugCategory[index]),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(PracticeData.drugCategoryDesc[index][PracticeData.drugCategory[index]],style: kBodyText.copyWith(fontSize: 12),),
              ),
              const SizedBox(height: 10),

            ],
          ),
          itemCount: PracticeData.drugCategoryDesc.length
      ),
    );
  }
}
