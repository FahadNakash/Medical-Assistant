import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class Preferences extends GetxController{
  static Preferences get preferencesGetter=>Get.find<Preferences>();

  late SharedPreferences preferences;
  final String _user='user';

  Future<Preferences> init()async{
    preferences=await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveUserSession(User user) async{
    await preferences.setString(_user, json.encode(user.toJson()));
  }

  User getUserSession(){
    final userSession=preferences.getString(_user);
    return userSession!=null?User.fromJson(json.decode(userSession)):User();
  }

  Future<void> removeUserSession()async {
    await preferences.remove(_user);
  }

}