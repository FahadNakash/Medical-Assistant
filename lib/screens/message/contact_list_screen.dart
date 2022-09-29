import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:patient_assistant/components/custom_dialog_box.dart';

import '../../components/custom_circle_progress_indicator.dart';
import '../../components/empty.dart';
import '../../constant.dart';
import '../../controllers/app_controller.dart';
import '../../models/user_model.dart';
import '../../services/firestore_helper.dart';
import 'widgets/contact_tile.dart';
class ContactListScreen extends StatefulWidget {
  // final List<UserModel> contacts;
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final appController=AppController.appGetter;
  final firestoreHelper=FirestoreHelper.firestoreGetter;

  bool _isLoading=false;
  final String kEmptyText='Look Like you have not added any Specialist to your profile.To contact your specialist first you will need to add them to your profile';


  @override
  void initState() {
    super.initState();
    getAddedUser();
  }

  Widget customAppbar(Size size,context){
    bool  isPotrait=(MediaQuery.of(context).orientation==Orientation.portrait)?true:false;
    return  Container(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      height:isPotrait?size.height*0.2:size.height*0.4,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.white,
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_rounded,
                color: kHeading2Color,
                size: 25,
              )),
          const SizedBox(height: kDefaultHeight,),
          const Text('Select Contact',style: TextStyle(color: Colors.cyan,fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
          const SizedBox(height: kDefaultHeight/3,),
          RichText(
              text:  TextSpan(
                  text: 'The Following are from your ',
                  style: const TextStyle(color: kTextColor,fontFamily: 'Comfortaa',fontSize: 12),
                  children: <InlineSpan>[
                    TextSpan(
                        text:appController.user.isDoctor?'My Patients ':'My Doctors',
                        style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,)
                    ),
                    const TextSpan(text: 'List')
                  ]
              )
          )
        ],
      ),
    );
  }
  Widget contactList(Size size,context){
    bool _isPotrait=MediaQuery.of(context).orientation==Orientation.portrait?true:false;
    return SizedBox(
      width: size.width,
      height:_isPotrait?size.height*0.75:size.height*0.5,
      child:_isLoading
          ?const CustomCircleProgressIndicator()
          :firestoreHelper.usersChats.isEmpty
          ?Empty(middleText: kEmptyText, onPressed: (){})
          :ListView.builder(
          itemCount: firestoreHelper.usersChats.length,
          itemBuilder: (context,index){
          return ContactTile(user: firestoreHelper.usersChats[index]['contact'],chatId: firestoreHelper.usersChats[index]['chatId'],);
        }
    )
    );

  }

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          customAppbar(size, context),
          contactList(size, context),
        ],
      ),
    );
  }
  Future<void> getAddedUser()async{
    setState((){
      _isLoading=true;
    });
    try{
      final List<UserModel> _addedContacts=await firestoreHelper.getAddedContacts();
      firestoreHelper.usersChats.clear();
      if (_addedContacts.isNotEmpty){
        for (var contact in _addedContacts){
          if (firestoreHelper.chatsDocs.isNotEmpty){
            for (var chatDoc in firestoreHelper.chatsDocs){
              final List<String> _temp=List.from(chatDoc.data()['connections']);
              final _chatId = chatDoc.id;
              if (_temp.contains(contact.uid)){
                firestoreHelper.usersChats.add({
                  'chatId': _chatId,
                  'contact': contact,
                  'contactId': contact.uid
                });
                break;
              }
            }
          }else{
            // chats is empty
            firestoreHelper.usersChats.add({
              'chatId': null,
              'contact': contact,
              'contactId': contact.uid
            });
          }
          if (!firestoreHelper.usersChats.any((element) => element['contactId']==contact.uid)){
            firestoreHelper.usersChats.add({
              'chatId': null,
              'contact': contact,
              'contactId': contact.uid
            });
          }
        }
      }
    }on SocketException catch(_){
      Get.dialog(
          CustomDialogBox(
              title: 'Alert',
              middleText: kNoConErrMsg,
              onPressed: (){
                Get.back();
                getAddedUser();
              }
          )
      );
    }on FirebaseException catch(e){
      Get.dialog(
          CustomDialogBox(
              title: 'Opp/s',
              middleText: e.message.toString(),
              onPressed: (){
                Get.back();
                getAddedUser();
              }
          )
      );
    }catch(_){
    }
    setState((){
      _isLoading=false;
    });
  }


// Future<void> getAddedUser()async{
  //   setState((){
  //     _isLoading=true;
  //   });
  //   try{
  //     firestoreHelper.usersChats.clear();
  //     if (widget.contacts.isNotEmpty){
  //       for (var contact in widget.contacts){
  //         if (firestoreHelper.chatsDocs.isNotEmpty){
  //           for (var chatDoc in firestoreHelper.chatsDocs){
  //             final List<String> _temp=List.from(chatDoc.data()['connections']);
  //             final _chatId = chatDoc.id;
  //             if (_temp.contains(contact.uid)){
  //                 firestoreHelper.usersChats.add({
  //                   'chatId': _chatId,
  //                   'contact': contact,
  //                   'contactId': contact.uid
  //                 });
  //                 break;
  //             }
  //           }
  //         }else{
  //           // chats is empty
  //           firestoreHelper.usersChats.add({
  //             'chatId': null,
  //             'contact': contact,
  //             'contactId': contact.uid
  //           });
  //         }
  //         if (!firestoreHelper.usersChats.any((element) => element['contactId']==contact.uid)){
  //           firestoreHelper.usersChats.add({
  //             'chatId': null,
  //             'contact': contact,
  //             'contactId': contact.uid
  //           });
  //         }
  //       }
  //     }
  //   }on SocketException catch(_){
  //     Get.dialog(
  //         CustomDialogBox(
  //         title: 'Alert',
  //         middleText: kNoConErrMsg,
  //         onPressed: (){
  //           Get.back();
  //           getAddedUser();
  //         }
  //     )
  //     );
  //   }on FirebaseException catch(e){
  //     Get.dialog(
  //         CustomDialogBox(
  //             title: 'Opp/s',
  //             middleText: e.message.toString(),
  //             onPressed: (){
  //               Get.back();
  //               getAddedUser();
  //             }
  //         )
  //     );
  //   }catch(_){
  //   }
  //   setState((){
  //     _isLoading=false;
  //   });
  // }
  //



}

