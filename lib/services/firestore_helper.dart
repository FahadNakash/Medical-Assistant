import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:patient_assistant/controllers/app_controller.dart';

import '../models/user_model.dart';
import '../utilities/api_exception.dart';

class FirestoreHelper extends GetxController{
   static FirestoreHelper  get firestoreGetter=>Get.find<FirestoreHelper>();

   static const String _users='users';
   final FirebaseFirestore _firestore=FirebaseFirestore.instance;

   Future<UserModel> getCloudData(String uid)async{
      final _getUser=await _firestore.collection(_users).doc(uid).get();
      if (_getUser.data()!=null) {
         UserModel _user=UserModel.fromMap(_getUser.data()!);
         return _user;
      }
      throw ApiException('No user data was found in the app or cloud storage.You have to proceed to Form Screen to enter detail');
   }

   Future<void> setCloudData(UserModel user)async{
      Map<String,dynamic> _user=user.toMap();
      await _firestore.collection(_users).doc(user.uid).set(_user);
}








}