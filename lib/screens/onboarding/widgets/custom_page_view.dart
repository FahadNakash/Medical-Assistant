
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/onboarding_model.dart';
import '../../../constant.dart';
class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key,required this.onPageChanged,required this.pageController,required this.size}) : super(key: key);
  final Function(int) onPageChanged;
  final PageController pageController;
  final Size size;
  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}
class _CustomPageViewState extends State<CustomPageView> {
  @override
  Widget build(BuildContext context) {
    final screenOrientation=MediaQuery.of(context).orientation;
    return SizedBox(
      height: (screenOrientation==Orientation.portrait)?widget.size.height*0.60:widget.size.height*0.40,
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: kDefaultPadding*0.3),
        child: PageView.builder(
          controller: widget.pageController,
          onPageChanged:widget.onPageChanged,
            scrollDirection: Axis.horizontal,
            itemCount:onBoardingItems.length,
            itemBuilder: (context,index)=>Column(
          children: [
            SizedBox(height: (screenOrientation==Orientation.portrait)?kDefaultHeight/2:0,),
            Text('${onBoardingItems[index].title}',style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height:(screenOrientation==Orientation.portrait)?kDefaultHeight*2:0,),
            Text('${onBoardingItems[index].descriptions}',style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),
            const SizedBox(height: kDefaultHeight,),
            SvgPicture.asset(onBoardingItems[index].imageUrl!,height:(screenOrientation==Orientation.portrait)?widget.size.height*0.30:widget.size.height*0.20,),
          ],
        )),
      ),
    );
  }
}
