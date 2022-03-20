import 'package:flutter/material.dart';
class AuthUser{
late final String uid;
late final String email;
AuthUser({
  required this.uid,
  required this.email,
});

AuthUser.fromJson(Map<String,dynamic> userData){
  uid=userData['uid'];
  email=userData['email'];
}
Map<String,dynamic> toJson(){
  final data=<String,dynamic>{};
  data['uid']=uid;
  data['email']=email;
  return data;
}
}
