class User{
 late final String? uid;
 late final  String? email;
 late final  String? name;
 late final  String? country;
 late final  String? city;
 late final  int? phoneNumber;
 late final  String? practiceType;
 late final  List<String>? specialities;
 late final  int? experience;
 late final  String? appointmentFee;
 late final  String? workplaceName;
 late final  String? workplaceAddress;
User({
   this.uid,
   this.email,
   this.name,
   this.country,
   this.city,
   this.phoneNumber,
   this.practiceType,
   this.specialities,
   this.experience,
   this.appointmentFee,
   this.workplaceName,
   this.workplaceAddress,
});
User.fromJson(Map<String,dynamic> userData){
  uid=userData['uid'];
  email=userData['email'];
  name=userData['name'];
  country=userData['country'];
  city=userData['city'];
  phoneNumber=userData['phoneNumber'];
  practiceType=userData['practiceType'];
  specialities=userData['specialities'] ;
  experience=userData['experience'];
  appointmentFee=userData['appointmentFee'];
  workplaceName=userData['workplaceName'];
  workplaceAddress=userData['workplaceAddress'];
}
Map<String,dynamic> toJson(){
  final data=<String,dynamic>{};
  data['uid']=uid;
  data['email']=email;
  data['name']=name;
  data['country']=country;
  data['city']=city;
  data['phoneNumber']=phoneNumber;
  data['practiceType']=practiceType;
  data['specialities']=specialities;
  data['experience']=experience;
  data['appointmentFee']=appointmentFee;
  data['workplaceName']=workplaceName;
  data['workplaceAddress']=workplaceAddress;
  return data;
}
}
