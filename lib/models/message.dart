import '../../../utilities/utils.dart';

class Message{
 late final String text;
 late final DateTime createdAt;
 late final String receiverName;
 late final String receiverImageUrl;
 late final String senderName;
 late final String senderImageUrl;
 late final String senderUid;
 late final String receiverUid;

 Message({
  required this.text,
  required this.createdAt,
  required this.receiverName,
  required this.receiverImageUrl,
  required this.senderName,
  required this.senderImageUrl,
  required this.senderUid,
  required this.receiverUid,
});

 Message.fromJson(Map<String,dynamic> json){
  text=json['text'];
  createdAt=Utils.toDateTime(json['createdAt']);
  receiverUid= json['receiverUid'];
  receiverName= json['receiverName'];
  receiverImageUrl= json['receiverImageUrl'];
  senderUid=json['senderUid'];
  senderName= json['senderName'];
  senderImageUrl= json['senderImageUrl'];
  }

 Map<String,dynamic> toJson(){
  return {
   'text':text,
   'createdAt':Utils.fromDateTimeToJson(createdAt),
   'receiverUid':receiverUid,
   'receiverName':receiverName,
   'receiverImageUrl':receiverImageUrl,
   'senderUid':senderUid,
   'senderName':senderName,
   'senderImageUrl':senderImageUrl,
  };
 }


}