import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_assistant/models/quote_model.dart';

import '../../../constant.dart';
import '../../../providers/quotes_api.dart';
class DailyQuotes extends StatefulWidget {
  const DailyQuotes({Key? key}) : super(key: key);

  @override
  State<DailyQuotes> createState() => _DailyQuotesState();
}


class _DailyQuotesState extends State<DailyQuotes> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController=AnimationController(
      duration: const Duration(milliseconds: 1900),
        vsync: this
    );
    super.initState();
  }




  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    final orientation=MediaQuery.of(context).orientation;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding/4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Quote of the day',style: TextStyle(color: Color(0xff9394C7),fontFamily: 'Montserrat',fontWeight: FontWeight.w600,fontSize: 25)),
          const SizedBox(height: kDefaultHeight/3),
          Container(
            padding: const EdgeInsets.all(kDefaultPadding),
            height:(orientation==Orientation.portrait)?height*0.2:height*0.4,
            width: width,
            decoration: const BoxDecoration(
                color: Color(0xff9394C7),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child:FutureBuilder<Quotes?>(

                future: QuoteApi().getQuote(),
                builder: (context,snapShot) {
                  if(snapShot.connectionState==ConnectionState.waiting){
                    return const Center(child: CupertinoActivityIndicator(color: Colors.white,animating: true,radius: 20),);
                  }
                  if (snapShot.hasError) {
                    return const Center(child: Text('Something wrong',style: TextStyle(color: Colors.white,fontSize: 10),));
                  }
                  if (snapShot.hasData){

                    if (snapShot.data==null) {
                      return const Center(child: Text('Nothing to show',style: TextStyle(color: Colors.white,fontSize: 10),));
                    }
                    _animationController.forward();
                    return FadeTransition(

                      opacity:_animationController,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: kDefaultHeight/2),
                        Text(' ‘‘ ${snapShot.data!.quote}’’ ' ,style: const TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,),
                        const Spacer(),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(snapShot.data!.author,style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'))),
                      ],
                    ),
                    );
                  }
                  return const Center(
                    child: Text('Please check internet connection !',style: TextStyle(color: Colors.white,fontSize: 10)),);
                }
            ),
          ),
        ],
      ),
    );
  }
}
