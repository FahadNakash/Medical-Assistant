class Doctor{
 Doctor();
 static const String role='Doctor';
 String name='';
 String country='';
 String city='';
 String phoneNumber='';
 String practiceType='';
 List<String> specialities=[];
 String experience='';
 String appointmentFee='';
 String workplaceName='';
 String workplaceAddress='';


 Doctor.fromMap(Map<String ,dynamic> map){
  name=map['name'];
  country=map['country'];
  city=map['city'];
  phoneNumber=map['phoneNumber'];
  practiceType=map['practiceType'];
  specialities=List<String>.from(map['specialities']);
  experience=map['experience'];
  appointmentFee=map['appointmentFee'];
  workplaceName=map['workplaceName'];
  workplaceAddress=map['workplaceAddress'];
 }

 Map<String,dynamic> toMap()=>{
  'name':name,
  'country':country,
  'city':city,
  'phoneNumber':phoneNumber,
  'practiceType':practiceType,
  'specialities':specialities,
  'experience':experience,
  'appointmentFee':appointmentFee,
  'workplaceName':workplaceName,
  'workplaceAddress':workplaceAddress,
 };



}


