import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_assistant/constant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}
class _SideDrawerState extends State<SideDrawer> with SingleTickerProviderStateMixin{
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
          top: 0,
          bottom: 0,
          left: isOpenSideAysnc.data!?0:-width,
          right:isOpenSideAysnc.data!?0:width-45,
          child: Row(
            children: [
              Expanded(
                child:Container(
                  color: Colors.grey.shade50,
                  height: height,
                  child: Column(
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
                            Text('Habib Fahad',style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none,fontFamily: 'Comfortaa',fontWeight: FontWeight.normal),),
                            SizedBox(height: 10),
                            Text('Habib Fahad',style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none,fontFamily: 'Comfortaa',fontWeight: FontWeight.normal),)
                          ],
                        ),
                      ),

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
          ),
        );
      }
    );
  }
}
class CustomMenuClipper extends CustomClipper{
  @override
  getClip(Size size) {
    // TODO: implement getClip
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
  
}
