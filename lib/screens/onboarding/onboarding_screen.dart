import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
import 'package:patient_assistant/screens/onboarding/widgets/dotted_container.dart';
import 'package:patient_assistant/screens/onboarding/widgets/footer_bar.dart';
import '../../components/app_icon.dart';
import '../onboarding/widgets/custom_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key,}) : super(key: key);
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen>{
  final pageController=PageController(initialPage: 0);
  int index=0;
  onPageChanged(value){
    index=value;
    setState(() {
    });
  }
  @override
  void initState(){
    firstLogin();
    super.initState();
  }
  Future<void> firstLogin()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.setBool('firstRun', true);
  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: kDefaultHeight/2),
          //AppIcon(height: 90,),
          const AppIcon(height: kDefaultHeight*3+10,),
          CustomPageView(onPageChanged: onPageChanged,pageController: pageController,size: size,),
          const SizedBox(height: kDefaultHeight/2,),
          DottedContainer(currentIndex: index,),
          Expanded(flex: 2,child: FooterBar(pageController: pageController,size: size,index: index,)),
        ],
      ),
    );
  }
}








































// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../Size_Configure.dart';
// import '../components/dotted_container.dart';
// import '../components/footer_bar.dart';
// import '../../../controllers/onboarding_controller.dart';
// class OnBoardingScreen extends StatefulWidget {
//   @override
//   _OnBoardingScreenState createState() => _OnBoardingScreenState();
// }
// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   final PageController _pageController=PageController(initialPage: 0);
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig.setSize(context);
//     var boxSizeV=SizeConfig.containersizeV;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//                 height:120,
//                 child: SvgPicture.asset('assets/images/app_logo.svg',height: 60,)
//             ),
//             SizedBox(
//               height: boxSizeV! * 5,
//             ),
//             Expanded(
//                 flex: 7,
//                 child:GetX<OnboardingContoller>(
//                   builder:(controller){
//                     return PageView.builder(
//                       controller: _pageController,
//                       itemCount: controller.items.length,
//                       itemBuilder: (context,index){
//                         return Column(
//                           children: [
//                             Text(controller.items[index].title!,style:Theme.of(context).textTheme.headline6,),
//                             SizedBox(
//                               height: boxSizeV * 10,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10,right: 10),
//                               child: Text(controller.items[index].descriptions!,style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),
//                             ),
//                             SizedBox(
//                               height: boxSizeV * 5,
//                             ),
//                             SvgPicture.asset(controller.items[index].imageUrl!,height: 250,),
//                           ],);},
//                       onPageChanged: (value){
//                         setState(() {
//                          controller.currentIndex=value.obs;
//                         },);},
//                     );
//                   }
//                 )
//             ),
//             // dotts conatiners
//             Expanded(
//               child: DottedCOntainer(),
//             ),
//
//             GetX<OnboardingContoller>(builder: (controller){
//               return controller.currentIndex == controller.items.length-1 ?
//               CustomButton()
//              // Footer
//                   :Expanded(
//               child: FooterBar(_pageController),
//               );
//             })
//           ],
//         ),
//       ));
//   }
// }
// class CustomButton extends StatelessWidget {
//   const CustomButton({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: InkWell(
//           onTap: (){},
//           child: Container(
//             width: 90,
//             height: 50,
//             decoration: BoxDecoration(
//               gradient:LinearGradient(
//                   colors: [
//                     Color.fromRGBO(56, 223, 126, 0.5),
//                     Color.fromRGBO(74,164, 153,1),
//                   ],
//                   begin:Alignment.topRight,
//                   end: Alignment.bottomLeft
//               ),
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             child: Center(child: Text('Click me ',style: TextStyle(color: Colors.white),)),
//           )
//       ),
//     );
//   }
// }



