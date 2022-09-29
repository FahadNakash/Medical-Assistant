import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patient_assistant/components/conform_dialog_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../message/widgets/chat_messages.dart';
import '../search_specialist/search_specialist_detail_screen.dart';
import '../../providers/country_data.dart';
import '../../../models/user_model.dart';
import '../../components/custom_dialog_box.dart';
import '../../models/message.dart';
import '../../services/firestore_helper.dart';
import '../../settings/preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firestoreHelper = FirestoreHelper.firestoreGetter;
  final prefController = Preferences.preferencesGetter;

  String? chatId = Get.arguments['chatId'];
  final _user = UserModel.fromMap(Get.arguments['user']);

  Future _uploadMessage(
      UserModel sender, UserModel receiver, String message) async {
    try {
      final newMessage = Message(
              text: message,
              createdAt: DateTime.now(),
              receiverUid: receiver.uid,
              receiverName: receiver.userName,
              receiverImageUrl: receiver.imageUrl,
              senderUid: sender.uid,
              senderName: sender.userName,
              senderImageUrl: sender.imageUrl)
          .toJson();
      if (chatId == null) {
        final newChatRef = _firestore.collection('chats').doc();
        chatId = newChatRef.id;
        firestoreHelper.usersChats
            .removeWhere((element) => element['contactId'] == _user.uid);
        firestoreHelper.usersChats
            .add({'chatId': chatId, 'contact': _user, 'contactId': _user.uid});
        setState(() {});
      }
      _firestore.collection('chats').doc(chatId).set({
        'connections': [sender.uid, receiver.uid],
        'message': newMessage,
        'receiver': receiver.uid,
        'sender': sender.uid,
      });
      final setNewMessage = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('message')
          .doc();
      setNewMessage.set(newMessage);
    } on SocketException catch (_) {
      Get.dialog(CustomDialogBox(
          title: 'Connection Issue',
          middleText:
              'Please Make Sure that your device connect to the internet',
          onPressed: () {
            Get.back();
          }));
    } on FirebaseException catch (e) {
      Get.dialog(CustomDialogBox(
          title: e.code.toString(),
          middleText: e.message!,
          onPressed: () {
            Get.back();
          }));
    } catch (e) {
      Get.dialog(CustomDialogBox(
          title: 'Opp/s Something wrong',
          middleText: e.toString(),
          onPressed: () {
            Get.back();
          }));
    }
  }

  bool get _isPresent {
    return appController.user.contacts.contains(_user.uid);
  }

  Future<void> _updateDoctorContacts() async {
    if (!appController.user.contacts.contains(_user.uid)) {
      appController.user.contacts.add(_user.uid);
      await firestoreHelper.setCloudData(appController.user);
      await prefController.saveUserSession(appController.user);
      setState(() {});
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                color: Colors.black,
                gradient: LinearGradient(
                  colors: [
                    Colors.lightGreen.withAlpha(190).withOpacity(0.4),
                    const Color(0xff329D9C).withAlpha(190).withOpacity(0.4)
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
          ),
          customAppbar(size),
          ChatMessages(
            selectedUser: _user,
            chatId: chatId,
            uploadMessage: _uploadMessage,
          )
        ],
      ),
    );
  }

  Widget customAppbar(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 14, left: 10, right: 10),
      height: size.height * 0.1,
      width: size.width,
      child: Row(
        children: [
          customIconButtons(
              icon: Icons.arrow_back_rounded,
              onTap: () {
                Get.back();
              }),
          Expanded(
              flex: 12,
              child: Text(
                _user.userName,
                style: kDoctorName,
                textAlign: TextAlign.center,
              )),
          const Spacer(),
          _user.isDoctor
              ? customIconButtons(
                  icon: Icons.phone,
                  onTap: () async {
                    await _makePhoneCall(
                        '+${CountryData.countryInfo[_user.doctor.country]![0]}' +
                            _user.doctor.phoneNumber);
                  })
              : _isPresent
                  ? const SizedBox()
                  : customIconButtons(
                      icon: Icons.person_add,
                      onTap: () async {
                        Get.dialog(
                            ConformDialogBox(
                              title: 'Conform',
                              content: 'Are sure you want to add this user to your Patients List',
                              conform: ()async{await _updateDoctorContacts(); Navigator.of(context).pop();},
                            )
                        );
                        // await _updateDoctorContacts();
                      }),
          const SizedBox(
            width: kDefaultWidth / 3,
          ),
          customIconButtons(
              icon: Icons.help_outline,
              onTap: () {
                Get.to(
                  () => const SearchedDoctorDetailScreen(),
                  arguments: {'user': _user.toMap(), 'fromChatScreen': true},
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 600),
                );
              }),
        ],
      ),
    );
  }

  Widget customIconButtons(
      {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.white,
      onTap: onTap,
      child: Icon(icon, color: kHeading2Color),
    );
  }
}
