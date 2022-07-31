import 'dart:io';

import 'doctor_model.dart';
import 'patient_model.dart';

class UserModel{
  UserModel();
  String uid='';
  String email='';
  String role='';
  String imageUrl='';
  String imagePath='';
  File imageFile=File('');
  Patient patient=Patient();
  Doctor doctor=Doctor();

  bool get isPatient=>role.isNotEmpty && role==Patient.role;
  bool get isDoctor=>role.isNotEmpty && role==Doctor.role;

  String get userName{
    if (role=='Patient') {
      return patient.name;
    }else{
      return doctor.name;
    }

  }
  String get userCountry{
    if (role==Patient.role) {
      return patient.country;
    }else{
      return doctor.country;
    }
  }

  UserModel.fromMap(Map<String,dynamic> map){
    uid=map['uid'];
    email=map['email'];
    role=map['role'];
    imageUrl=map['imageUrl'];
    if (isPatient) {
      patient=Patient.fromMap(map['user']);
    }else if (isDoctor) {
      doctor=Doctor.fromMap(map['user']);
    }
  }

  Map<String, dynamic> toMap(){
    final _userData=<String,dynamic>{};
    _userData['uid']=uid;
    _userData['email']=email;
    _userData['role']=role;
    _userData['imageUrl']=imageUrl;
    if (isPatient) {
      _userData['user']=patient.toMap();
    }else if (isDoctor) {
      _userData['user']=doctor.toMap();
    }
    return _userData;
  }



}


// class User1{
//  late final  String? uid;
//  late final  String? email;
//  late final String? imageUrl;
//  late final String? imagePath;
//  late final  String? name;
//  late final int? patientAge;
//  late final List<dynamic>? patientDisease;
//  late final  String? country;
//  late final  String? city;
//  late final  int? phoneNumber;
//  late final  String? practiceType;
//  late final  List<String>? specialities;
//  late final  int? experience;
//  late final  String? appointmentFee;
//  late final  String? workplaceName;
//  late final  String? workplaceAddress;
//  late final  String? countryCode;
//  late final  String? currency;
//  late final  String? role;
// User1(
//     {
//    this.uid,
//    this.email,
//    this.imageUrl,
//    this.imagePath,
//    this.name,
//    this.patientAge,
//    this.patientDisease,
//    this.country,
//    this.city,
//    this.phoneNumber,
//    this.practiceType,
//    this.specialities,
//    this.experience,
//    this.appointmentFee,
//    this.workplaceName,
//    this.workplaceAddress,
//    this.countryCode,
//    this.currency,
//    this.role,
// });
// User1.fromJson(Map<String,dynamic> userData){
//   uid=userData['uid'];
//   email=userData['email'];
//   imageUrl=userData['imageUrl'];
//   imagePath=userData['imagePath'];
//   name=userData['name'];
//   patientAge=userData['patientAge'];
//   patientDisease=List<String>.from(userData['patientDisease']??[]);
//   country=userData['country'];
//   city=userData['city'];
//   phoneNumber=userData['phoneNumber'];
//   practiceType=userData['practiceType'];
//   specialities=List<String>.from(userData['specialities']??[]) ;
//   experience=userData['experience'];
//   appointmentFee=userData['appointmentFee'];
//   workplaceName=userData['workplaceName'];
//   workplaceAddress=userData['workplaceAddress'];
//   countryCode=userData['countryCode'];
//   currency=userData['currency'];
//   role=userData['role'];
// }
// Map<String,dynamic> toJson(){
//   final data=<String,dynamic>{};
//   data['uid']=uid;
//   data['email']=email;
//   data['imageUrl']=imageUrl;
//   data['imagePath']=imagePath;
//   data['name']=name;
//   data['patientAge']=patientAge;
//   data['patientDisease']=patientDisease;
//   data['country']=country;
//   data['city']=city;
//   data['phoneNumber']=phoneNumber;
//   data['practiceType']=practiceType;
//   data['specialities']=specialities;
//   data['experience']=experience;
//   data['appointmentFee']=appointmentFee;
//   data['workplaceName']=workplaceName;
//   data['workplaceAddress']=workplaceAddress;
//   data['countryCode']=countryCode;
//   data['currency']=currency;
//   data['role']=role;
//   return data;
// }
// }
