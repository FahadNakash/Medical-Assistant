import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

import '../components/shimmer_effect.dart';
import '../models/user_model.dart';
import '../constant.dart';
import '../components/doctor_card.dart';
import '../controllers/app_controller.dart';
import '../services/firestore_helper.dart';
class RecommendedDoctors extends StatefulWidget {
  const RecommendedDoctors({Key? key}) : super(key: key);

  @override
  State<RecommendedDoctors> createState() => _RecommendedDoctorsState();
}

class _RecommendedDoctorsState extends State<RecommendedDoctors> {
  final appController=AppController.appGetter;
  final firestoreHelper=FirestoreHelper.firestoreGetter;
  final InternetConnectionChecker _internetConnectionChecker=InternetConnectionChecker();
  late final StreamSubscription _streamSubscription;

  bool _isConnected=false;


  @override
  void initState() {
    super.initState();
    _streamSubscription=_internetConnectionChecker.onStatusChange.listen((event) {
      if (InternetConnectionStatus.connected==event) {
        _isConnected=true;
        setState(() {});
      }else{
        _isConnected=false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      height: 165,
      margin:const EdgeInsets.symmetric(vertical: 10),
      child:_isConnected
          ?Column(
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
           Flexible(child: _drawRecommededDocTiles())
        ],
      )
          :Container(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xff371A45),width: 2),
        ),
        child:Lottie.asset('assets/lotti/no_internet.json',animate: true,repeat: true),
      ),
    );
  }

  Widget _drawRecommededDocTiles(){
    return FutureBuilder<List<UserModel>>(
        future: firestoreHelper.allDoctors(appController.user.uid),
        builder: (context,snapShot){
          if (snapShot.connectionState==ConnectionState.waiting) {
            return const ShimmerEffect();
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
