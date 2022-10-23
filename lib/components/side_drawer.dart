import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import '../components/my_icons_icons.dart';
import '../constant.dart';
import '../controllers/app_controller.dart';
import '../models/user_model.dart';
import '../routes/app_pages.dart';
import '../settings/preferences.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer>
    with SingleTickerProviderStateMixin {
  final appController=AppController.appGetter;

  AnimationController? animatedController;
  Stream<bool>? isOpenStream;
  StreamSink<bool>? isOpenStreamSink;
  StreamController<bool>? isOpenStreamController;

  @override
  void initState() {
    animatedController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    isOpenStreamController = PublishSubject<bool>();
    isOpenStreamSink = isOpenStreamController!.sink;
    isOpenStream = isOpenStreamController!.stream;
    super.initState();
  }

  @override
  void dispose() {
    animatedController!.dispose();
    isOpenStreamController!.close();
    isOpenStreamSink!.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = animatedController!.status;
    final isAnimationComplete = animationStatus == AnimationStatus.completed;
    if (isAnimationComplete) {
      isOpenStreamSink!.add(false);
      animatedController!.reverse();
    } else {
      isOpenStreamSink!.add(true);
      animatedController!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final orientation = MediaQuery.of(context).orientation;
    return StreamBuilder<bool>(
        initialData: false,
        stream: isOpenStream,
        builder: (context, isOpenSideAsync) {
          return AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              top: 18,
              bottom: 0,
              left: isOpenSideAsync.data! ? 0 : -width,
              right: isOpenSideAsync.data! ? 0 : width - 35,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.grey.shade50,
                      height: height,
                      child: Column(
                        children: [
                          //image box
                          Container(
                            height: (orientation == Orientation.portrait)
                                ? 250
                                : 150,
                            width: 1000,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight:
                                    (orientation == Orientation.portrait)
                                        ? const Radius.circular(60)
                                        : const Radius.circular(50),
                              ),
                              gradient: const LinearGradient(colors: [
                                kInputTextColor,
                                kPrimaryColor,
                              ]),
                            ),
                            child: (orientation == Orientation.portrait)
                                ? GetBuilder<AppController>(
                                  builder: (context) {
                                    return Column(
                                        children: [
                                          Container(
                                            height: 130,
                                            width: 130,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 5,
                                                      offset: Offset(2, 10))
                                                ]),
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(20)),
                                                child: Image.memory(
                                                  appController.user.imageFile.readAsBytesSync(),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            appController.user.userName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.normal),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            appController.user.email,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                decoration: TextDecoration.none,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      );
                                  }
                                )
                                : GetBuilder<AppController>(
                                  builder: (context) {
                                    return Row(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 130,
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 5,
                                                      offset: Offset(2, 10))
                                                ]),
                                            child: ClipRRect(
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(20)),
                                                child: Image.file(File(appController.user.imagePath),fit: BoxFit.cover,)),
                                          ),
                                          const SizedBox(width: kDefaultWidth),
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: kDefaultWidth,
                                              ),
                                              Text(
                                                appController.user.userName,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              const Spacer(),
                                              Text(
                                                appController.user.email,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                  }
                                ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Expanded(
                            child: CustomNavigationTiles(),
                          ),
                          // ListTile box
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, -1),
                    child: GestureDetector(
                      onTap: () {
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
              ));
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;

    // TODO: implement getClip
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;
  const CustomListTile(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText2!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 22,
        );
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          Text(
            title,
            style: bodyText1,
          ),
        ],
      ),
    );
  }
}

class CustomNavigationTiles extends StatelessWidget {
  final appController = AppController.appGetter;
  final prefController = Preferences.preferencesGetter;
  CustomNavigationTiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Material(
      child: SingleChildScrollView(
        physics: (orientation == Orientation.portrait)
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  CustomListTile(
                      title: 'My Profile',
                      icon: const Icon(MyIcons.human_man_people_person_profile_icon,
                          size: 25, color: kblue),
                      onTap: () {
                        Get.toNamed(
                          Routes.user_profile,
                        );
                      }),
                  const SizedBox(
                    height: kDefaultHeight * 2,
                  ),
                  CustomListTile(
                      title: appController.user.isDoctor?'My Patients':'My Doctors',
                      icon: const Icon(
                        MyIcons.avatar_coronavirus_covid19_man_mask_icon,
                        size: 25,
                        color: kblue,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.my_contacts);
                      }),
                  const SizedBox(
                    height: kDefaultHeight * 2,
                  ),
                  CustomListTile(
                      title: 'Messages',
                      icon: const Icon(
                          MyIcons.chat_conversation_dialogue_discussion_interface_icon,
                          color: kblue,
                          size: 30),
                      onTap: () {
                        Get.toNamed(Routes.message_list);
                      }),
                  const SizedBox(
                    height: kDefaultHeight * 2,
                  ),
                  CustomListTile(
                    title: 'Pharmacies',
                    icon: const Icon(
                        MyIcons
                            .building_healthcare_hospital_medical_nursing_icon,
                        size: 25,
                        color: kblue),
                    onTap: () {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin: EdgeInsets.only(
                            top: (orientation == Orientation.portrait)
                                ? kDefaultHeight * 5
                                : kDefaultHeight * 3,
                            left: kDefaultPadding),
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey.withOpacity(0.4),
                              endIndent: 40,
                              indent: 40,
                            ),
                            InkWell(
                              hoverColor: Colors.white,
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onTap: () async {
                                FirebaseAuth _auth = FirebaseAuth.instance;
                                await _auth.signOut();
                                await prefController.removeUserSession();
                                appController.user=UserModel();
                                Get.offAllNamed(Routes.auth);
                              },
                              child: Row(
                                children: const [
                                  RotatedBox(
                                      quarterTurns: 2,
                                      child: Icon(
                                        Icons.login,
                                        color: kErrorColor,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    width: kDefaultWidth / 2,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: kErrorColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'Comfortaa',
                                        decoration: TextDecoration.none),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
