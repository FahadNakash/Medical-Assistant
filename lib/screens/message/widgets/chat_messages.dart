import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../../models/message.dart';
import '../../../models/user_model.dart';
import '../../../constant.dart';
import '../widgets/message_bubble.dart';

class ChatMessages extends StatefulWidget {
  final UserModel selectedUser;
  final String? chatId;
  final Function(UserModel sender,UserModel receiver,String message) uploadMessage;
   const ChatMessages({Key? key, required this.selectedUser,required this.chatId,required this.uploadMessage}) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late final TextEditingController _messageController;
  String msg = '';

  @override
  void initState(){
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  bool isSender(){
    return (widget.selectedUser.uid==appController.user.uid);
  }
  Alignment getAlign(){
    if (widget.selectedUser.uid==appController.user.uid) {
      return Alignment.bottomRight;
    }else{
      return Alignment.topLeft;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kDefaultPadding * 3.5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          _messagesBody(),
          _newMessage()
        ],
      ),
    );
  }

   Widget _messagesBody(){
    return StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
    stream: FirebaseFirestore.instance.collection('chats').doc(widget.chatId).collection('message').orderBy('createdAt',descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot,){
        if (snapshot.hasError) {
          return const Expanded(child:  Center(child: Text('Something went wrong',style: TextStyle(fontSize: 15)),));
        }
        if (snapshot.hasData){
          if (snapshot.data!=null){
            final _messages=snapshot.data!.docs;
            if (  _messages.isEmpty) {
              return const Expanded(child: Center(child: Text('Say hello!'),));
            }else {
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (context, index){
                      final _convertMsg=_messages[index].data() as Map<String, dynamic>;
                      Message _singleMsg=Message.fromJson(_convertMsg);
                      return MessageBubble(message: _singleMsg,isMe:_singleMsg.senderUid==appController.user.uid?true:false,);
                    }
                ),
              );
            }
          }else{
            return const Center(child: Text('Something went wrong',style: TextStyle(fontSize: 15)),);
          }
        }
        return Expanded(child: Container());
      }
  );
  }

  Widget _newMessage(){
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 2,
                controller: _messageController,
                enableSuggestions: true,
                autocorrect: true,
                style: const TextStyle(color: kPrimaryColor, fontSize: 14,),
                cursorColor: kPrimaryColor,
                cursorHeight: 15,
                cursorWidth: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Type message here',
                  hintStyle: TextStyle(color: kPrimaryColor.withOpacity(0.3)),
                  enabled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: kPrimaryColor.withOpacity(0.6)),
                      gapPadding: 10),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                      BorderSide(color: kPrimaryColor.withOpacity(0.6))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                      BorderSide(color: kPrimaryColor.withOpacity(0.3))),
                ),
                onChanged: (v) {
                  msg = v.trim();
                  setState(() {});
                },
              )),
          const SizedBox(width: kDefaultWidth / 2),
          InkWell(
            onTap: msg.isEmpty?null:()async{
              FocusScope.of(context).unfocus();
              await widget.uploadMessage(appController.user,widget.selectedUser,_messageController.text);
              _messageController.clear();
              msg='';
              setState(() {});
            },
            child: FaIcon(FontAwesomeIcons.solidPaperPlane,
                color: msg.isEmpty
                    ? kPrimaryColor.withOpacity(0.3)
                    : kPrimaryColor),
          )
        ],
      ),
    );
  }
}
