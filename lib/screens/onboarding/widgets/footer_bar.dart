import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/onboarding.dart';
import '../../../routes/app_pages.dart';
import '../../../components/app_button.dart';
class FooterBar extends StatelessWidget {
 final PageController pageController;
 final Size size;
 final int index;
 FooterBar({required this.pageController,required this.size,required this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height*0.2,
      child:AnimatedSwitcher(
        duration: Duration(milliseconds: 1500),
        child:(index==onBoardingItems.length-1)
            ?AppButton( textSize: 15,defaultLinearGradient: true,text: 'Get Started',height: 40,width: 110,onPressed: (){
              Get.toNamed(Routes.auth);
        },)
            :Container(
          child: Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                    pageController.animateToPage(6,duration: Duration(milliseconds: 2000,),curve: Curves.fastLinearToSlowEaseIn);
                  },
                    child: Text('Skip',style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12
                    ),),),
                  TextButton(
                      onPressed: (){
                    pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                  },
                      child: Text('Next',style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 12
                      ),)
                  ),
                ],
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
