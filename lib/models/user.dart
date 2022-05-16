import 'dart:io';
class User{
 late final  String? uid;
 late final  String? email;
 late final String? imageUrl;
 late final String? imagePath;
 late final  String? name;
 late final int? patientAge;
 late final List<dynamic>? patientDisease;
 late final  String? country;
 late final  String? city;
 late final  int? phoneNumber;
 late final  String? practiceType;
 late final  List<String>? specialities;
 late final  int? experience;
 late final  String? appointmentFee;
 late final  String? workplaceName;
 late final  String? workplaceAddress;
 late final  String? countryCode;
 late final  String? currency;
 late final  String? role;
User(
    {
   this.uid,
   this.email,
   this.imageUrl,
   this.imagePath,
   this.name,
   this.patientAge,
   this.patientDisease,
   this.country,
   this.city,
   this.phoneNumber,
   this.practiceType,
   this.specialities,
   this.experience,
   this.appointmentFee,
   this.workplaceName,
   this.workplaceAddress,
   this.countryCode,
   this.currency,
   this.role,
});
User.fromJson(Map<String,dynamic> userData){
  uid=userData['uid'];
  email=userData['email'];
  imageUrl=userData['imageUrl'];
  imagePath=userData['imagePath'];
  name=userData['name'];
  patientAge=userData['patientAge'];
  patientDisease=userData['patientDisease'];
  country=userData['country'];
  city=userData['city'];
  phoneNumber=userData['phoneNumber'];
  practiceType=userData['practiceType'];
  specialities=userData['specialities'] ;
  experience=userData['experience'];
  appointmentFee=userData['appointmentFee'];
  workplaceName=userData['workplaceName'];
  workplaceAddress=userData['workplaceAddress'];
  countryCode=userData['countryCode'];
  currency=userData['currency'];
  role=userData['role'];
}
Map<String,dynamic> toJson(){
  final data=<String,dynamic>{};
  data['uid']=uid;
  data['email']=email;
  data['imageUrl']=imageUrl;
  data['imagePath']=imagePath;
  data['name']=name;
  data['patientAge']=patientAge;
  data['patientDisease']=patientDisease;
  data['country']=country;
  data['city']=city;
  data['phoneNumber']=phoneNumber;
  data['practiceType']=practiceType;
  data['specialities']=specialities;
  data['experience']=experience;
  data['appointmentFee']=appointmentFee;
  data['workplaceName']=workplaceName;
  data['workplaceAddress']=workplaceAddress;
  data['countryCode']=countryCode;
  data['currency']=currency;
  data['role']=role;
  return data;
}
}
