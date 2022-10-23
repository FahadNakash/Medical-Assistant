import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../components/app_button.dart';
import '../../routes/app_pages.dart';
import '../../../components/custom_text_button.dart';
import '../../../providers/country_data.dart';
import '../../../providers/practice_data.dart';
import '../../../constant.dart';
import '../../controllers/app_controller.dart';
import '../../models/user_model.dart';
import '../search_specialist/widgets/title_chip.dart';

class SearchedDoctorDetailScreen extends StatefulWidget {
  const SearchedDoctorDetailScreen({Key? key}) : super(key: key);

  @override
  State<SearchedDoctorDetailScreen> createState() =>
      _SearchedDoctorDetailScreenState();
}

class _SearchedDoctorDetailScreenState
    extends State<SearchedDoctorDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final appController = AppController.appGetter;

  final UserModel userDetail = UserModel.fromMap(Get.arguments['user']);
  final bool _fromChatScreen = Get.arguments['fromChatScreen'] as bool;

  String? chatId;
  bool _isEnable = false;

  Future<void> _getChatDoc() async {
    final _currentUserChats = await _firestore
        .collection('chats')
        .where('connections', arrayContains: appController.user.uid)
        .get();
    final _chatDocs = _currentUserChats.docs;
    if (_chatDocs.isNotEmpty) {
      for (var doc in _chatDocs) {
        final List<String> _connections = List.from(doc.data()['connections']);
        if (_connections.contains(userDetail.uid)) {
          chatId = doc.id;
          setState(() {});
        }
      }
    }
    setState(() {
      _isEnable = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _getChatDoc();
  }

  String getDiagnose(String speciality) {
    return PracticeData.practiceDescription[speciality]!;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(size),
              _drawUserDetail(size, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget customAppBar(Size size) {
    bool _isPotrait =
        (MediaQuery.of(context).orientation == Orientation.portrait)
            ? true
            : false;
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.only(left: kDefaultPadding, bottom: 30),
            width: size.width,
            height: _isPotrait ? size.height * 0.30 : size.height * 0.5,
            decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(80)),
                gradient: LinearGradient(
                  colors: [
                    Colors.lightGreen.withAlpha(190),
                    const Color(0xff329D9C).withAlpha(190)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kblue,
                    )),
                Row(
                  children: [
                    Container(
                      height: kDefaultHeight * 5,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38.withOpacity(0.3),
                              offset: const Offset(0, 6),
                              blurRadius: 8,
                              spreadRadius: -2)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: MemoryImage(kTransparentImage),
                          image: NetworkImage(userDetail.imageUrl),
                        ),
                      ),
                    ),
                    const SizedBox(width: kDefaultWidth / 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userDetail.isDoctor
                              ? 'Dr ${userDetail.userName.capitalize}'
                              : userDetail.userName.capitalize!,
                          style: const TextStyle(
                              color: kblue,
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: kDefaultHeight / 3,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 4),
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(colors: [
                                Color(0xff8BC6EC),
                                Color(0xff9599E2)
                              ])),
                          child: Text(
                            userDetail.isDoctor
                                ? 'Over ${userDetail.doctor.experience} years of Experience'
                                : 'Age : ${userDetail.patient.age}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: kDefaultHeight / 2),
                        if (userDetail.isPatient)
                          Text(
                            'From ' +
                                userDetail.patient.city +
                                ',' +
                                userDetail.patient.country,
                            style: const TextStyle(
                                color: kGrey, fontSize: 12),
                          )
                      ],
                    )
                  ],
                )
              ],
            )),
      ],
    );
  }

  Widget _drawUserDetail(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kDefaultPadding * 2),
      width: size.width,
      child: userDetail.isDoctor
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleChip(
                    title: (userDetail.doctor.specialities.length == 1)
                        ? userDetail.doctor.specialities[0]
                        : 'Specialities'),
                const SizedBox(height: kDefaultHeight),
                (userDetail.doctor.specialities.length == 1)
                    ? Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding,
                        ),
                        child:
                            Text(getDiagnose(userDetail.doctor.specialities[0]),
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 14,
                                )),
                      )
                    : Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 2 + 10),
                        child: Wrap(
                          runSpacing: 10,
                          spacing: 10,
                          alignment: WrapAlignment.center,
                          children: specialitiesButtons(),
                        ),
                      ),
                const SizedBox(height: kDefaultHeight),
                const TitleChip(title: 'WorkPlace'),
                const SizedBox(height: kDefaultHeight),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                            width: size.width * 0.6 + 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    userDetail.doctor.workplaceName.capitalize!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                    maxLines: 2),
                                const SizedBox(height: kDefaultHeight / 4),
                                Text(
                                    userDetail.doctor.workplaceAddress
                                            .capitalize! +
                                        ',' +
                                        userDetail.doctor.country.capitalize!,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    maxLines: 2),
                              ],
                            ),
                          ),
                          const Spacer(),
                          CustomTextButton(
                            text: 'Direction',
                            onTap: () {},
                            width: 70,
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 2,
                            vertical: kDefaultPadding / 2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Appointment fee :',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(width: kDefaultWidth / 2),
                                Text(
                                  userDetail.doctor.appointmentFee +
                                      ' ' +
                                      CountryData.countryInfo[
                                          userDetail.doctor.country]![1][0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultHeight / 3),
                            Row(
                              children: [
                                Text(
                                  'Phone number :',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(width: kDefaultWidth / 2),
                                Text(
                                  '+${CountryData.countryInfo[userDetail.doctor.country]![0]}' +
                                      userDetail.doctor.phoneNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: kDefaultHeight / 3),
                            Divider(
                              color: kGrey.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                      if (appController.user.role == 'Patient')
                        appController.user.contacts.contains(userDetail.uid)
                            ? _fromChatScreen
                                ? const SizedBox()
                                : AppButton(
                                    height: 45,
                                    width: 140,
                                    onPressed: _isEnable
                                        ? () {
                                            Get.toNamed(Routes.chat,
                                                arguments: {
                                                  'chatId': chatId,
                                                  'user': userDetail.toMap(),
                                                });
                                          }
                                        : () {},
                                    text: 'Message',
                                    textSize: 15,
                                    defaultLinearGradient: true)
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextButton(
                                      onTap: () async {
                                        appController.user.contacts
                                            .add(userDetail.uid);
                                        setState(() {});
                                        await firestoreHelper
                                            .setCloudData(appController.user);
                                        await prefController.saveUserSession(
                                            appController.user);
                                        Get.snackbar('Confirmation ',
                                            'Doctor Add Successfully',
                                            icon: const Icon(
                                              Icons.done,
                                              color: kPrimaryColor,
                                            ),
                                            duration: const Duration(
                                                milliseconds: 2500),
                                            colorText: kPrimaryColor,
                                            borderColor: kPrimaryColor,
                                            borderRadius: 20,
                                            borderWidth: 2,
                                            backgroundColor: Colors.white,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                      },
                                      text: 'Add to My Doctor',
                                      fontSize: 12,
                                      width: 140,
                                      height: 45,
                                      borderRadius: 40),
                                  //message screen
                                  AppButton(
                                      height: 45,
                                      width: 140,
                                      onPressed: _isEnable
                                          ? () {
                                              Get.toNamed(Routes.chat,
                                                  arguments: {
                                                    'chatId': chatId,
                                                    'user': userDetail.toMap(),
                                                  });
                                            }
                                          : () {},
                                      text: 'Message',
                                      textSize: 15,
                                      defaultLinearGradient: true)
                                ],
                              )
                    ],
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleChip(title: 'Medical Condition'),
                const SizedBox(height: kDefaultHeight),
                Center(
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    alignment: WrapAlignment.center,
                    children: diseasesButtons(),
                  ),
                )
              ],
            ),
    );
  }

  List<Widget> specialitiesButtons() {
    final List<Widget> _chipsButtons = [];
    for (var speciality in userDetail.doctor.specialities) {
      _chipsButtons.add(InkWell(
        splashColor: kblue,
        highlightColor: Colors.white,
        onTap: () {
          Get.dialog(diagnoseDialogueBox(speciality));
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 3, horizontal: kDefaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kblue.withOpacity(0.7)),
          ),
          child: Text(speciality,
              style: const TextStyle(color: kblue, fontSize: 12)),
        ),
      ));
    }
    return _chipsButtons;
  }

  List<Widget> diseasesButtons() {
    final List<Widget> _chipsButtons = [];
    for (var disease in userDetail.patient.diseases) {
      _chipsButtons.add(InkWell(
        splashColor: kblue,
        highlightColor: Colors.white,
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding / 3, horizontal: kDefaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kblue.withOpacity(0.7)),
          ),
          child: Text(disease,
              style: const TextStyle(color: kblue, fontSize: 12)),
        ),
      ));
    }
    return _chipsButtons;
  }

  Widget diagnoseDialogueBox(String speciality) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: const EdgeInsets.all(kDefaultPadding),
      title: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [kSecondaryColor, kPrimaryColor],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Text(speciality,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              fit: FlexFit.loose,
              child: Divider(color: kGrey.withOpacity(0.5))),
          InkWell(
            highlightColor: Colors.white,
            splashColor: Colors.white,
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.red.shade200,
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 15),
            ),
          ),
        ],
      ),
      content: Container(
        margin: const EdgeInsets.only(right: 5),
        padding: const EdgeInsets.only(
          left: kDefaultPadding,
        ),
        child: Text(getDiagnose(speciality), style: kBodyText),
      ),
    );
  }
}
