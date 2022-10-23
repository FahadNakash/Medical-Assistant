class Patient{
  Patient();
  static const String role='Patient';
  String name='';
  String country='';
  String city='';
  int age=0;
  List<String> diseases=[];
  // List<String> addDoctors=[];


  Patient.fromMap(Map<String,dynamic> map){
    name=map['name'];
    country=map['country'];
    city=map['city'];
    age=map['age'];
    diseases=List<String>.from(map['diseases']);
    }

  Map<String,dynamic> toMap()=>{
    'name':name,
    'country':country,
    'city':city,
    'age':age,
    'diseases':diseases,
    // 'addDoctors':addDoctors,
  };

}