import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_assistant/settings/preferences.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import '../../../routes/app_pages.dart';
import '../../../components/empty.dart';
import '../../../services/firestore_helper.dart';
import '../../../models/user_model.dart';
import '../../../components/doctor_card.dart';
import '../../../controllers/app_controller.dart';
import '../../../components/shimmer_effect.dart';

class MyContacts extends StatefulWidget {
  final Size size;
  const MyContacts({Key? key, required this.size}) : super(key: key);

  @override
  State<MyContacts> createState() => _MyContactsState();
}

class _MyContactsState extends State<MyContacts> {
  final appController = AppController.appGetter;
  final firestoreHelper = FirestoreHelper.firestoreGetter;

  Future<void> deleteAddedDoctor(String selectedDocUid) async {
    appController.user.contacts.removeWhere((uid) => uid == selectedDocUid);
    // firestoreHelper.addedContacts.removeWhere((user) => user.uid == selectedDocUid);
    await firestoreHelper.setCloudData(appController.user);
    await Preferences.preferencesGetter.saveUserSession(appController.user);
  }

  @override
  Widget build(BuildContext context) {
    bool  _isPotrait=(MediaQuery.of(context).orientation==Orientation.portrait)?true:false;
    return FutureBuilder<List<UserModel>>(
        future: firestoreHelper.getAddedContacts(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                height: _isPotrait?widget.size.height * 0.7+ 50:widget.size.height*0.5+25,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: appController.user.contacts.length,
                    itemBuilder: (context, index) => const ShimmerEffect()));
          }
          if (snapshot.hasError) {
            return const Text('Oops Something Wrong',
                style: TextStyle(
                  fontSize: 25,
                ));
          }
          if (snapshot.hasData){
            if (snapshot.data != null){
              final List<UserModel> _contacts = snapshot.data!;
              return _contacts.isNotEmpty
                  ?SizedBox(
                  height: _isPotrait?widget.size.height * 0.7+ 50:widget.size.height*0.5+25,
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: _contacts.length,
                      itemBuilder: (context, index) => Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.horizontal,
                          confirmDismiss: (direction) {
                            return conformDialogBox(context);
                          },
                          onDismissed: (direction) {
                            deleteAddedDoctor(_contacts[index].uid);
                            if (appController.user.contacts.isEmpty) {
                              setState(() {});
                            }
                          },
                          background: backgroundBox(),
                          secondaryBackground:secondaryBackgroundBox(),
                          child: DoctorCard(
                            user: _contacts[index]
                            ,)
                      )))
                  :appController.user.isDoctor
                  ?const Empty(
                  middleText: 'There are currently no Patients in your profile.You can add to your Patients List when they contact',
                  showButton: false,
              )
                  :Empty(
                  middleText: 'Looks Like you have not added any Specialist to your profile.Head over to search screen to add some specialists',
                  showButton: true,
                  onPressed: ()async{
                    await Get.toNamed(Routes.search_specialist);
                    setState(() {});
                  }
              );
            }
          }
          return Empty(
            middleText:
                'Look like you have not added any Specialist to your profile.Head over to search screen to add some specialist',
            showButton: true,
            onPressed: () async {
              await Get.toNamed(Routes.search_specialist,);
              setState(() {});
            },
          );
        });
  }
}

Widget backgroundBox() {
  return Container(
    padding: const EdgeInsets.only(right: 220),
    height: 200,
    color: Colors.red,
    child: const Icon(Icons.delete, size: 60, color: Colors.white),
  );
}

Widget secondaryBackgroundBox() {
  return Container(
    padding: const EdgeInsets.only(left: 200),
    width: 200,
    height: 200,
    color: Colors.red,
    child: const Icon(Icons.delete, size: 60, color: Colors.white),
  );
}

Future<bool> conformDialogBox(BuildContext context) async {
  final _shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white.withOpacity(0.9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text(
              'WARNING',
              style: kDialogBoxTitle,
              textAlign: TextAlign.start,
            ),
            content: const Text(
              'Are you sure you want to remove this Doctor from your List of Doctors',
              style: kDialogBoxBody,
              textAlign: TextAlign.start,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                      child: const Text('Yes',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.of(context).pop(true),
                      color: kErrorColor,
                      splashColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  const SizedBox(
                    width: kDefaultWidth / 2,
                  ),
                  MaterialButton(
                      child: const Text('No',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () => Navigator.of(context).pop(false),
                      color: kInputTextColor,
                      splashColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ],
              )
            ],
          ));

  return _shouldPop ?? false;
}
