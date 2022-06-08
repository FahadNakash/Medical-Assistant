import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/circle_icon_button.dart';
import '../../database/firebase.dart';
import '../../controllers/app_controller.dart';
import '../../controllers/user_profile_controller.dart';
import '../../constant.dart';
class UserProfileScreen extends StatefulWidget{
   UserProfileScreen({Key? key}) : super(key: key);
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}
class _UserProfileScreenState extends State<UserProfileScreen> {
  final cloudDbGetter=CloudDatabase.cloudDatabaseGetter;
  final appController=AppController.appGetter;
  final userProfileController=UserProfileController.userProfileController;

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    final orientation = MediaQuery.of(context).orientation;
    final height = MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers:[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 200,
            toolbarHeight: 150,
            leading: GestureDetector(
              onTap: (){
                Get.back();
              },
              // back Button
              child: Container(
                  //color: Colors.green,
                  margin: EdgeInsets.all(10),
                  width: 30,
                  height: 30,
                  child: Icon(Icons.keyboard_backspace)
              ),
            ),
            flexibleSpace: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // appbar background color
                Container(
                  height: MediaQuery.of(context).viewPadding.vertical + 200,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightGreen.withAlpha(190),
                        Color(0xff329D9C).withAlpha(190)
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
                // curve container
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                  //    color: Colors.yellow,
                    color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      )
                  ),
                ),
                // image box
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: [
                      //dispaly Image
                     Obx(() =>  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         height: 115,
                         width: 115,
                         decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(20),
                             boxShadow: [BoxShadow(color: Colors.black38, offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1)],
                             image: DecorationImage(
                                 fit: BoxFit.cover,
                                 image:userProfileController.selectImage.isEmpty?FileImage(File(appController.imageFolderPath)):FileImage(File(userProfileController.selectImage.value))
                             )
                         ),
                       ),
                     ),),
                      // pick icon
                      Positioned(
                        bottom: 0,
                          right: 0,
                          child:GestureDetector(
                            onTap: (){
                              Get.bottomSheet(
                                customBottomSheet(),
                                backgroundColor: Colors.white,
                              );
                            },
                            child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff44A08D), Color(0xff093637)],
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                        ),
                              child: Icon(Icons.edit,color: Colors.white,size: 20),
                      ),
                          )
                      )

                    ],
                  ),
                ),

              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.red,
              height: 900,
            ),
          )
        ],
      ),
    );
  }
  Widget customBottomSheet(){
    return Container(
      height: 150,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile Photo',
              style: TextStyle(color: Colors.black, fontSize: 20)),
          Row(
            children: [
              // gallery
              Column(
                children: [
                  CircleIconButton(
                      onTap: () async {
                        await userProfileController.pickImage(ImageSource.gallery);
                        Get.back();
                      },
                      colors: [
                        Colors.purple.withOpacity(0.5),
                        Colors.pink,
                      ],
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                      )),
                  Text(
                    'Gallery',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
                ],
              ),
              SizedBox(width: kDefaultPadding),
              //camera
              Column(
                children: [
                  CircleIconButton(
                      onTap: ()async {
                        await roleController.getImage(ImageSource.camera);
                        Get.back();
                      },
                      colors: [Color(0xff36013F), Colors.teal.withOpacity(0.7)],
                      icon: Icon(
                        Icons.camera,
                        color: Colors.white,
                      )),
                  Text(
                    'Camera',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
                ],
              ),
              SizedBox(width: kDefaultPadding),
              if (userProfileController.selectImage.isNotEmpty)
                Column(
                  children: [
                    CircleIconButton(
                        onTap: ()async {
                          userProfileController.selectImage.value='';
                          Get.back();
                        },
                        colors: [
                          Color.fromRGBO(102, 0, 0, 1),
                          kErrorColor
                        ],
                        icon: Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        )),
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    )
                  ],
                ),
              //IconButton(onPressed: (){}, icon: Icon(Icons.camera),color: Colors.red),
            ],
          )
        ],
      ),
    );
  }
}

