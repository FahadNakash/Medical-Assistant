import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../constant.dart';
import '../components/custom_circle_progress_indicator.dart';
import '../components/doctor_card.dart';
import '../controllers/app_controller.dart';
import '../services/firestore_helper.dart';
class RecommendedDoctors extends StatelessWidget {
  RecommendedDoctors({Key? key}) : super(key: key);
  final appController=AppController.appGetter;
  final firestoreHelper=FirestoreHelper.firestoreGetter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin:const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const SizedBox(height: kDefaultHeight/2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(width: kDefaultWidth/2),
              Text('Recommended Doctors',style: kSearchHeading2,),
              Spacer(),
              Text('Swipe',style: TextStyle(fontSize: 10,color:  Color(0xffF2C6C6)),),
              Icon(Icons.arrow_circle_left_rounded,color: Color(0xffF2C6C6),),
              SizedBox(width: kDefaultWidth/2),
            ],
          ),
          const SizedBox(height: kDefaultHeight/2,),
           Expanded(child: _drawRecommededDocTiles())
        ],
      ),
    );
  }

  Widget _drawRecommededDocTiles(){
    return FutureBuilder<List<UserModel>>(
        future: firestoreHelper.allDoctors(appController.user.uid),
        builder: (context,snapShot){
          if (snapShot.connectionState==ConnectionState.waiting) {
            return const Center(child: CustomCircleProgressIndicator());
          }if (snapShot.hasError){
            return const Center(
              child: Text('Oops Something Wrong',
                  style: TextStyle(
                    fontSize: 25,
                  )),
            );
          }if (snapShot.hasData){
            if (snapShot.data!=null) {
              final doctors =snapShot.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: doctors!.length,
                  itemBuilder: (context,index){
                  return DoctorCard(user: doctors[index],);
                  });
            }

          }
          return const Text('dwd');
        }
    );
  }
}
