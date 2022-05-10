import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import '../../../constant.dart';
import '../../../components/circle_icon_button.dart';
import 'package:get/get.dart';
import '../../../controllers/role_controller.dart';
import 'package:image_picker/image_picker.dart';
class ImagePickerContainer extends StatelessWidget {
  ImagePickerContainer({Key? key}) : super(key: key);
  final roleController = RoleController.roleGetter;
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding * 2),
      height: (orientation == Orientation.portrait)
          ? size.height * 0.3
          : size.height * 0.5,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Center(
                    child: Obx(
                  ()=>Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: kTextColor,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                                ),
                                BoxShadow(
                                  color: kTextColor.withOpacity(0.4),
                                  offset: Offset(-2, -2),
                                  blurRadius: 5,
                                )
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffc2e59c).withOpacity(0.8),
                                  Color(0xff64b3f4),
                                ],
                              )),
                          child:roleController.selectImage.value != ''
                                ?ClipRRect(
                              borderRadius:BorderRadius.all(Radius.circular(20)),
                              child: Image.file(File(roleController.selectImage.value),
                                   fit: BoxFit.cover
                              )
                          )
                                :Icon(Icons.account_box_rounded,
                                    size: (orientation == Orientation.portrait)
                                        ? 140
                                        : 110,
                                    color: Colors.white
                          ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: (orientation == Orientation.portrait)
                        ? kDefaultPosition * 7
                        : kDefaultPosition * 6,
                    right: (orientation == Orientation.portrait)
                        ? kDefaultPosition * 4.9
                        : kDefaultPosition * 14,
                    //right: kDefaulPadding*5,
                    child: CircleIconButton(
                      onTap: () {
                        Get.bottomSheet(
                          customBottomSheet(),
                          backgroundColor: Colors.white,
                        );
                      },
                      colors: [
                        Color(0xff41A08D).withOpacity(0.4),
                        Color(0xff1B5751),
                      ],
                      icon: Icon(Icons.camera_enhance_outlined,
                          color: Colors.white, size: 17),
                    ),
                  )
                ],
              ),
            ),
          ),
          Text('(Please select a Profile Picture to proceed next)',
              style: Theme.of(context).textTheme.subtitle1),
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
              Column(
                children: [
                  CircleIconButton(
                      onTap: () async {
                        await roleController.getImage(ImageSource.gallery);
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
              if (roleController.selectImage.value!='')
              Column(
                children: [
                  CircleIconButton(
                        onTap: ()async {
                        roleController.selectImage.value='';
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
