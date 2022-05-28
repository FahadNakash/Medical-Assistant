import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
class DailyQuotes extends StatelessWidget {
  const DailyQuotes({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quote of the day',style: TextStyle(color: Color(0xff9394C7),fontFamily: 'Roboto',fontWeight: FontWeight.w600)),
          SizedBox(height: kDefaultHeight/3),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            height:height*0.2,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xff9394C7),
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' ‘‘ If you respect yourself in stressful situations, it will help you see the positiveâ€¦ It will help you see the message in the mess.’’ ' ,style: TextStyle(color: Colors.white,fontSize: 15,)),
                Align(
                  alignment: Alignment.bottomRight,
                    child: Text('authorName',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Roboto'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
