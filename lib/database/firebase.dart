import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:patient_assistant/controllers/app_controller.dart';



import '../models/user.dart';
import '../utilities/api_exception.dart';


class CloudDatabase extends GetxController{
   static CloudDatabase  get cloudDatabaseGetter=>Get.find<CloudDatabase>();

   static const String _users='users';
   FirebaseFirestore _firestore=FirebaseFirestore.instance;

   Future<User> getCloudData(String uid)async{
      final _getUser=await _firestore.collection(_users).doc(uid).get();
      if (_getUser.data()!=null) {
         User _user=User.fromJson(_getUser.data()!);
         return _user;
      }
      throw ApiException('No user data was found in the app or cloud storage.You have to proceed to Form Screen to enter detail');
   }

   Future<void> setCloudData(User user,String uid)async{
      Map<String,dynamic> _user=user.toJson();
      final _setUser=await _firestore.collection(_users).doc(uid).set(_user);



}








}