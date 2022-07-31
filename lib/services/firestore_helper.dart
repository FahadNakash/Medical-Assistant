import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


import '../components/custom_dialog_box.dart';
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



   Future<List<UserModel>> getDoctors(String uid)async{
      try{
         bool _isInternetConnect=await InternetConnectionChecker().hasConnection;
         if (_isInternetConnect) {
            final List<UserModel> _doctor=[];
            final _getUser=await  _firestore.collection(_users).where('role',isEqualTo: 'Doctor').get();
            for (var element in _getUser.docs) {
               if (element.data()['uid']!=uid) {
                  _doctor.add(UserModel.fromMap(element.data()));
               }
            }
            return _doctor;
         }else{
            Get.dialog(
                CustomDialogBox(
                    title: 'Connection Issue', middleText: 'Please Make Sure that your device connect to the internet', onPressed: (){Get.back();}));
         }
      }on FirebaseException catch(e){
         Get.dialog(
             CustomDialogBox(
                 title: e.toString(), middleText: 'Please Make Sure that your device connect to the internet', onPressed: (){Get.back();}));
      }catch(e){
         Get.dialog(
             CustomDialogBox(
                 title: '$e', middleText: 'Please Make Sure that your device connect to the internet', onPressed: (){Get.back();}));
      }
      throw ApiException('No user data was found in the app or cloud storage.You have to proceed to Form Screen to enter detail');
   }








}