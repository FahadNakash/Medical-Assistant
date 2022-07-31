
// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/circle_icon_button.dart';
import '../../../constant.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/user_profile_controller.dart';


// ignore: must_be_immutable
class CustomSliverAppBar extends StatefulWidget {
  File? newSelectImage;
  final void Function(ImageSource) pickImage;
  final VoidCallback removeImage;
  final bool backButtonState;
    CustomSliverAppBar({
    required this.newSelectImage,
    required this.pickImage,
    required this.removeImage,
    required this.backButtonState,
    Key? key}) : super(key: key);

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {

  final userProfileController=UserProfileController.userProfileController;
  final appController=AppController.appGetter;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 200,
      toolbarHeight: 150,
      leading: GestureDetector(
        onTap:widget.backButtonState?null: (){
          Get.back();
          widget.newSelectImage=null;
          },
        child: Container(
            margin: const EdgeInsets.all(10),
            width: 30,
            height: 30,
            child: const Icon(Icons.keyboard_backspace,color: kHeading2Color,)
        ),
      ),
      flexibleSpace: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.vertical + 200,
            decoration: BoxDecoration(
              color: Colors.black38,
              gradient: LinearGradient(
                colors: [
                  Colors.lightGreen.withAlpha(190),
                  const Color(0xff329D9C).withAlpha(190)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
          // curve container
          Container(
            height: 60,
            decoration: const BoxDecoration(
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 115,
                    width: 115,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black38, offset: Offset(0, 3), blurRadius: 5, spreadRadius: 1)
                        ],
                        image: DecorationImage(
                            fit: BoxFit.cover,
                          image:MemoryImage((widget.newSelectImage==null)?appController.user.imageFile.readAsBytesSync():widget.newSelectImage!.readAsBytesSync())
                          //image: FileImage(widget.newSelectImage??File(appController.user.imagePath)),
                        )
                    ),
                  ),
                ),
                Positioned(
                    bottom: 5,
                    right: 5,
                    child:GestureDetector(
                      onTap: (){
                        Get.bottomSheet(
                          customBottomSheet(),
                          backgroundColor: Colors.white,
                        );
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xff44A08D), Color(0xff093637)],
                            begin: Alignment.centerLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit,color: Colors.white,size: 17),
                      ),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customBottomSheet(){
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile Photo',
              style: TextStyle(color: Colors.black, fontSize: 20)),
          Row(
            children: [
              // gallery
              Column(
                children: [
                  CircleIconButton(
                      onTap: () async {
                       widget.pickImage(ImageSource.gallery);
                       Get.back();
                      },
                      colors: [
                        Colors.purple.withOpacity(0.5),
                        Colors.pink,
                      ],
                      icon: const Icon(
                        Icons.image,
                        color: Colors.white,
                      )),
                  const Text(
                    'Gallery',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
                ],
              ),
              const SizedBox(width: kDefaultPadding),
              //camera
              Column(
                children: [
                  CircleIconButton(
                      onTap: ()async {
                        widget.pickImage(ImageSource.camera);
                        Get.back();
                      },
                      colors: [const Color(0xff36013F), Colors.teal.withOpacity(0.7)],
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.white,
                      )),
                  const Text(
                    'Camera',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
                ],
              ),
              const SizedBox(width: kDefaultPadding),
              if (widget.newSelectImage!=null)
                Column(
                  children: [
                    CircleIconButton(
                        onTap: ()async {
                          widget.removeImage();
                          Get.back();
                        },
                        colors: const [
                          Color.fromRGBO(102, 0, 0, 1),
                          kErrorColor
                        ],
                        icon: const Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        )),
                    const Text(
                      'Delete',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    )
                  ],
                ),
            ],
          )
        ],
      ),
    );
  }
}

