import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class Preferences extends GetxController{
  static Preferences get preferencesGetter=>Get.find<Preferences>();

  late SharedPreferences preferences;
  final String _user='user';

  Future<Preferences> init()async{
    preferences=await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveUserSession(UserModel user) async{
    await preferences.setString(_user, jsonEncode(user.toMap()));
  }

  UserModel getUserSession(){
    final userSession=preferences.getString(_user);
    return userSession!=null?UserModel.fromMap(json.decode(userSession)):UserModel();
  }

  Future<void> removeUserSession()async{
    await preferences.remove(_user);
  }

}