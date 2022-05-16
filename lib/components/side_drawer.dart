import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../components/my_icons_icons.dart';
import '../constant.dart';
import '../controllers/app_controller.dart';
class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}
class _SideDrawerState extends State<SideDrawer> with SingleTickerProviderStateMixin{
  final appController=AppController.appGetter;

  AnimationController? animatedController;
  Stream<bool>? isOpenStream;
  StreamSink<bool>? isOpenStreamSink;
  StreamController<bool>? isOpenStreamController;

  FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
  FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;

  @override
  void initState() {
    animatedController=AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    isOpenStreamController=PublishSubject<bool>();
    isOpenStreamSink=isOpenStreamController!.sink;
    isOpenStream=isOpenStreamController!.stream;
    super.initState();
  }
  @override
  void dispose() {
   animatedController!.dispose();
   isOpenStreamController!.close();
   isOpenStreamSink!.close();
   super.dispose();
  }
  void onIconPressed(){
    final animationStatus=animatedController!.status;
    final isAnimationComplete=animationStatus==AnimationStatus.completed;
    if (isAnimationComplete) {
      isOpenStreamSink!.add(false);
      animatedController!.reverse();
    }else{
      isOpenStreamSink!.add(true);
      animatedController!.forward();
    }
  }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  StreamBuilder<bool>(
      initialData:false,
      stream: isOpenStream,
      builder: (context,isOpenSideAysnc) {
        return AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: 18,
          bottom: 0,
          left: isOpenSideAysnc.data!?0:-width,
          right:isOpenSideAysnc.data!?0:width-35,
          child: Row(
            children: [
              Expanded(
                child:Container(
                  color: Colors.grey.shade50,
                  height: height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: 1000,
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(60),
                          ),
                          gradient: LinearGradient(
                              colors: [
                                kInputTextColor,
                                kPrimaryColor,
                              ]
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration:BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius:BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        offset: Offset(2,10)
                                    )
                                  ]
                              ) ,
                            ),
                            SizedBox(height: 10),
                            Text(appController.user.name.toString(),style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none,fontFamily: 'Comfortaa',fontWeight: FontWeight.normal),),
                            SizedBox(height: 10),
                            Text('Habib Fahad',style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none,fontFamily: 'Comfortaa',fontWeight: FontWeight.normal),)
                          ],
                        ),
                      ),
                      SizedBox(height: 50,),
                      Container(
                        height: height*0.4,
                        padding: EdgeInsets.symmetric(horizontal: 60),
                        child: Column(
                          children: [
                            CustomListTile(title: 'My Profile',icon: Icon(MyIcons.human_man_people_person_profile_icon,size: 25,color: kHeading2Color),onTap: (){}),
                            SizedBox(height: kDefaultHeight*2,),
                            CustomListTile(title: 'My Patients',icon:Icon(MyIcons.avatar_coronavirus_covid19_man_mask_icon,size: 25,color: kHeading2Color,),onTap: (){}),
                            SizedBox(height: kDefaultHeight*2,),
                            CustomListTile(title: 'Messages',icon: Icon(MyIcons.chat_conversation_dialogue_discussion_interface_icon,color: kHeading2Color,size: 30),onTap: (){}),
                            SizedBox(height: kDefaultHeight*2,),
                            CustomListTile(title: 'Pharmacies',icon: Icon(MyIcons.building_healthcare_hospital_medical_nursing_icon,size: 25,color: kHeading2Color),onTap: (){},),
                          ],
                        ),
                      ),
                      Spacer(),
                      Divider(color: Colors.grey.withOpacity(0.4),endIndent: 40,indent: 40,),
                      Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding*4),
                          child:Row(
                            children: [
                              RotatedBox(
                          quarterTurns:2,
                                  child: Icon(Icons.login,color: kErrorColor,size: 30,)),
                              SizedBox(width: kDefaultWidth/2,),
                              Text('Log Out',style: TextStyle(
                                color: kErrorColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Comfortaa',
                                decoration: TextDecoration.none
                              ),)

                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment:Alignment(0,-1),
                child: GestureDetector(
                  onTap: (){
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      height: 110,
                      width: 35,
                      alignment: Alignment.centerLeft,
                      color: kPrimaryColor,
                      child: AnimatedIcon(
                        progress: animatedController!.view,
                        size: 30,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        );
      }
    );
  }
}
class CustomMenuClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){



    Paint paint=Paint();
    paint.color=Colors.white;
    final widht=size.width;
    final height=size.height;
    Path path=Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(widht-1, height/2-20, widht, height/2);
    path.quadraticBezierTo(widht+1, height/2+20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    path.close();
    return path;



    // TODO: implement getClip
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
    throw UnimplementedError();
  }
  
}
class CustomListTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  const CustomListTile({Key? key,required this.title,required this.icon,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText1=Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 22,
    );
    return  GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          SizedBox(width: 20),
          Text(
            title,style:bodyText1,),
        ],
      ),
    );
  }
}




