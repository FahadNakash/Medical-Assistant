import 'dart:io';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/custom_dialog_box.dart';
import '../utilities/api_exception.dart';
import '../constant.dart';
import '../models/user_model.dart';

class FirestoreHelper extends GetxController {
  static FirestoreHelper get firestoreGetter => Get.find<FirestoreHelper>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String _users = 'users';
  List<QueryDocumentSnapshot<Map<String,dynamic>>> chatsDocs=[];
  final List<Map<String ,dynamic>> usersChats=[];

  Future<UserModel> getCloudData(String uid) async {
    UserModel _user=UserModel();
    final _getUser = await _firestore.collection(_users).doc(uid).get();
    if (_getUser.data() != null) {
       _user = UserModel.fromMap(_getUser.data()!);
    }
    return _user;
  }

  Future<void> setCloudData(UserModel user) async {
    Map<String, dynamic> _user = user.toMap();
    await _firestore.collection(_users).doc(user.uid).set(_user);
  }

  Future<List<UserModel>> doctorsFilter(String uid) async {
    final List<UserModel> _doctors = [];
    final _getUser = await _firestore
        .collection(_users)
        .where('role', isEqualTo: 'Doctor')
        .get();
    for (var element in _getUser.docs) {
      if (element.data()['uid'] != uid) {
        _doctors.add(UserModel.fromMap(element.data()));
      }
    }
    return _doctors;
  }

  Future<List<UserModel>> getAllUsers(String uid) async{
    final List<UserModel> _allUsers = [];
    final _getUser = await _firestore.collection(_users).get();
    for (var element in _getUser.docs) {
      if (element.data()['uid'] != uid) {
        _allUsers.add(UserModel.fromMap(element.data()));
      }
    }
    return _allUsers;
  }

  Future<List<UserModel>> getAddedContacts() async {
    final List<UserModel> _temp =[];
    final List<UserModel> _users=await getAllUsers(appController.user.uid);
    for (var contact in appController.user.contacts) {
      for (var user in _users) {
        if (contact == user.uid) {
          _temp.add(user);
        }
      }
    }
    return _temp;
  }

  Future<void> deleteChat(String uid)async{
     try{
       await _firestore.collection('chats').doc(uid).delete();
     }on FirebaseException catch(e){
       Get.dialog(
           CustomDialogBox(title: 'Alert!', middleText: '${e.message}', onPressed: (){
             Get.back();
           }));
     }on SocketException catch(_){
       Get.dialog(
           CustomDialogBox(title: 'OOP\'s!', middleText: kNoConErrMsg, onPressed: (){
             Get.back();
           }));
     }catch(e){
       ApiException('$e');
     }
  }

  Future<List<UserModel>> allDoctors(String uid) async{
    final List<UserModel> _doctors = [];
    final _getUser = await _firestore.collection(_users).where('role',isEqualTo: 'Doctor').get();
    for (var element in _getUser.docs) {
      if (element.data()['uid'] != uid) {
        _doctors.add(UserModel.fromMap(element.data()));
      }
    }
    return _doctors;
  }




}
