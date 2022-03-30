import 'package:flutter/material.dart';
class AuthUser{
late final String uid;
late final String email;
late final String? formid;
AuthUser({
  required this.uid,
  required this.email,
  required this.formid
});
AuthUser.fromJson(Map<String,dynamic> userData){
  uid=userData['uid'];
  email=userData['email'];
  formid=userData['formid'];
}
Map<String,dynamic> toJson(){
  final data=<String,dynamic>{};
  data['uid']=uid;
  data['email']=email;
  data['formid']=formid;
  return data;
}
}
