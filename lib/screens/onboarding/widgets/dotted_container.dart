import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
import '../../../models/onboarding_model.dart';
class DottedContainer extends StatelessWidget {
  final int currentIndex;
   const DottedContainer({Key? key,required this.currentIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDefaultHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(onBoardingItems.length,(index)=>AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          height:(currentIndex==index)?12:8,
          width: (currentIndex==index)?14:8,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color:(currentIndex==index)? kHeading1Color:kPrimaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)
          )
          ,
        )),
      ),
    );
  }
}











// class DottedCOntainer extends StatelessWidget {
//   final onBoardController=Get.put(OnboardingContoller());
//   @override
//   Widget build(BuildContext context) {
//     return GetX<OnboardingContoller>(
//       builder:(controller){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:List.generate(controller.items.length, (index) {
//             return AnimatedContainer(
//               duration: Duration(milliseconds: 500),
//               curve: Curves.easeInOutCirc,
//               decoration: BoxDecoration(
//                   color: controller.currentIndex==index?Color.fromRGBO(1, 202, 133, 1):Color.fromRGBO(200, 230, 201, 1),
//                   shape: BoxShape.circle
//               ),
//               height:controller.currentIndex==index ?10 : 7,
//               width: 10,
//               margin: EdgeInsets.all(2),);
//           }) ,
//         );
//       }
//     );
//
//   }
// }
