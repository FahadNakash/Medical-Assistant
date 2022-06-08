import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_assistant/models/quote.dart';

import '../../../constant.dart';
import '../../../providers/quotes_api.dart';
class DailyQuotes extends StatelessWidget {
  const DailyQuotes({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final orientation=MediaQuery.of(context).orientation;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding/4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quote of the day',style: TextStyle(color: Color(0xff9394C7),fontFamily: 'Montserrat',fontWeight: FontWeight.w600,fontSize: 25)),
          SizedBox(height: kDefaultHeight/3),
          Container(
            padding: EdgeInsets.all(kDefaultPadding),
            height:(orientation==Orientation.portrait)?height*0.2:height*0.4,
            width: width,
            decoration: BoxDecoration(
                color: Color(0xff9394C7),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child:FutureBuilder<Quotes?>(
                future: QuoteApi().getQuote(),
                builder: (context,snapShot) {
                  if(snapShot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color: Colors.white),);
                  }
                  if (snapShot.hasError) {
                    return Center(child: Text('Something wrong',style: TextStyle(color: Colors.white,fontSize: 10),));
                  }
                  if (snapShot.hasData){
                    if (snapShot.data==null) {
                      return Center(child: Text('Nothing to show',style: TextStyle(color: Colors.white,fontSize: 10),));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kDefaultHeight/2),
                        Text(' ‘‘ ${snapShot.data!.quote}’’ ' ,style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),
                        Spacer(),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text('${snapShot.data!.author}',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'))),
                      ],
                    );
                  }
                  return Center(
                    child: Text('Please check internet connection !',style: TextStyle(color: Colors.white,fontSize: 10)),);
                }
            ),
          ),
        ],
      ),
    );
  }
}
