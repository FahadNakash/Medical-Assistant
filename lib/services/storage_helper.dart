import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper{
  static final FirebaseStorage _storage=FirebaseStorage.instanceFor(bucket: 'gs://medical-assistent-e5c11.appspot.com');
  static final Reference _userProfilesRef=_storage.ref().child('user_Images');


  static Future<String> uploadProfileImage({required String imageName,required File imageFile})async{
    UploadTask uploadTask=_userProfilesRef.child(imageName).putFile(imageFile);
    TaskSnapshot taskSnapshot=await Future.value(uploadTask);
    String imageUrl=await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }





}