import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:animations/animations.dart';
import 'package:patient_assistant/components/conform_dialog_box.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../models/doctor_model.dart';
import '../../utilities/utils.dart';
import '../../routes/app_pages.dart';
import '../../models/message.dart';
import '../../constant.dart';
import '../../controllers/app_controller.dart';
import '../../screens/message/contact_list_screen.dart';
import '../../services/firestore_helper.dart';
import '../../models/user_model.dart';

class MessagesListScreen extends StatefulWidget {
  const MessagesListScreen({Key? key}) : super(key: key);

  @override
  State<MessagesListScreen> createState() => _MessagesListScreenState();
}

class _MessagesListScreenState extends State<MessagesListScreen> {
  final appController = AppController.appGetter;
  final firestoreHelper = FirestoreHelper.firestoreGetter;

  final List<UserModel> _allUsers = [];
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  Future<void> _getUsers() async {
    _isReady = true;
    List<UserModel> temp = [];
    temp = await firestoreHelper.getAllUsers(appController.user.uid);
    if (temp.isNotEmpty) {
      for (var user in temp) {
        _allUsers.add(user);
      }
    }
    _isReady = false;
    setState(() {});
  }

  UserModel _selectedUser(String uid) {
    UserModel _user = UserModel();
    if (_allUsers.isNotEmpty) {
      for (var doctor in _allUsers) {
        if (doctor.uid == uid) {
          _user = doctor;
        }
      }
    }
    return _user;
  }

  Future<bool> _showExitDialogue(BuildContext context) async {
    final _shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text(
                'WARNING',
                style: kDialogBoxTitle,
                textAlign: TextAlign.start,
              ),
              content: const Text(
                'Are you sure you want to delete Chat',
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _customAppbar(size, context),
            const SizedBox(height: kDefaultHeight),
            Flexible(child: _checkMessageContactList())
          ],
        ),
        floatingActionButton: _customFloatingActionButton(),
      ),
    );
  }

  Widget _customAppbar(Size size, context) {
    bool isPotrait =
        (MediaQuery.of(context).orientation == Orientation.portrait)
            ? true
            : false;
    return Container(
      height: isPotrait ? size.height * 0.1 + 20 : size.height * 0.3,
      width: size.width,
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.white,
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                color: kHeading2Color,
                size: 25,
              )),
          const SizedBox(
            height: kDefaultHeight,
          ),
          const Text(
            'Messages',
            style: TextStyle(
                color: kHeading2Color,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _emptyChats() {
    return Container(
      margin: const EdgeInsets.only(top: 55),
      child: Column(
        children: [
          SvgPicture.asset('$kImagePath/empty_inbox.svg', height: 245),
          const SizedBox(height: kDefaultHeight),
          Text(
              'No message found.Click on the floating button to start a conversation',
              style:
                  TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 15),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _customFloatingActionButton() {
    return OpenContainer(
      // routeSettings: RouteSettings(arguments: _allUsers.isEmpty?[]:_allUsers,name: 'contact_screen'),
      transitionDuration: const Duration(milliseconds: 700),
      closedColor: kPrimaryColor,
      closedShape: const CircleBorder(),
      openBuilder: (context, _) => const ContactListScreen(),
      closedBuilder: (context, openContainer) => Container(
        padding: const EdgeInsets.all(kDefaultPadding / 1.5),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [
              Color(0xff037e87),
              kPrimaryColor,
            ])),
        child: const Icon(Icons.chat, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _checkMessageContactList() {
    return Material(
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('connections', arrayContains: appController.user.uid)
              .snapshots()
              .distinct(),
          builder: (context, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }
            if (chatSnapshot.hasError) {
              return const Text(
                'Something Wrong',
                style: kErrorStyle,
              );
            }
            if (chatSnapshot.hasData) {
              if (chatSnapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                    itemCount: chatSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final _chatMessage = Message.fromJson(
                          chatSnapshot.data!.docs[index].data()['message']);
                      final _isSender =(_chatMessage.senderUid == appController.user.uid)? true : false;
                      final _createdAt =Utils.convertDateTime(_chatMessage.createdAt);
                      final _chatId = chatSnapshot.data!.docs[index].id;
                      firestoreHelper.chatsDocs = chatSnapshot.data!.docs;
                      final UserModel _chatUser = _selectedUser(_isSender
                          ? _chatMessage.receiverUid
                          : _chatMessage.senderUid);
                      return Column(
                        key: UniqueKey(),
                        children: [
                          ListTile(
                            onTap: _isReady
                                ? null
                                : () {
                                    Get.toNamed(Routes.chat, arguments: {
                                      'chatId': _chatId,
                                      'user': _chatUser.toMap()
                                    });
                                  },
                            leading: Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38.withOpacity(0.3),
                                        offset: const Offset(0, 6),
                                        blurRadius: 8,
                                        spreadRadius: -2)
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage(_isSender
                                      ? _chatMessage.receiverImageUrl
                                      : _chatMessage.senderImageUrl),
                                ),
                              ),
                            ),
                            title: appController.user.role == Doctor.role
                                ? Text(
                                    _isSender
                                        ? _chatMessage.receiverName
                                        : _chatMessage.senderName,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15))
                                : Text(
                                    _isSender
                                        ? 'Dr.' + _chatMessage.receiverName
                                        : 'Dr.' + _chatMessage.senderName,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15)),
                            subtitle: Row(
                              children: [
                                Text(
                                  (_chatMessage.senderUid ==
                                          appController.user.uid)
                                      ? 'You:'
                                      : '${_chatMessage.senderName}:',
                                  style: const TextStyle(
                                      color: kPrimaryColor, fontSize: 10),
                                ),
                                const SizedBox(width: kDefaultWidth / 4),
                                Text(
                                  _chatMessage.text,
                                  style: const TextStyle(
                                      color: kTextColor, fontSize: 10),
                                ),
                              ],
                            ),
                            trailing: Text(_createdAt,
                                style: const TextStyle(
                                    color: kTextColor, fontSize: 12)),
                            onLongPress: () async {
                              Get.dialog(
                                  ConformDialogBox(
                                    title: 'Conform',
                                    content: 'Are your sure to delete this chat?',
                                    conformButtonColor: kErrorColor,
                                    conformTextColor: Colors.white,
                                    conformButtonBorder: kErrorColor,
                                    dissmisTextColor: kSecondaryColor,
                                    dissmisButtonColor: Colors.white,
                                    conform:()async{
                                      Get.back();
                                      await firestoreHelper.deleteChat(_chatId);
                                    }
                                  ));
                            },
                          ),
                          Divider(
                            color: kTextColor.withOpacity(0.5),
                            endIndent: 15,
                            indent: 15,
                          ),
                        ],
                      );
                    });
              } else {
                return _emptyChats();
              }
            }
            return const Text(
              'Something wrong',
              style: kErrorStyle,
            );
          }),
    );
  }
}
