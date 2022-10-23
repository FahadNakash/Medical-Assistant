class Drug {
  Drug({
    required this.name,
    required this.pregnancyCategory,
    required this.lactationCategory,
    required this.instructions,
    required this.genericId,
    required this.sideEffects,
    required this.howItWorks,
    required this.therapeutic,
    required this.usedFor,
    required this.strength,
    required this.schedule,
    required this.alcoholInteractionDescription,
    required this.alcoholNteraction,
    required this.therapeuticList,
  });
  late final String name;
  late final String? pregnancyCategory;
  late final String? lactationCategory;
  late final String instructions;
  late final int? genericId;
  late final String sideEffects;
  late final String howItWorks;
  late final String? therapeutic;
  late final String usedFor;
  late final String strength;
  late final String schedule;
  late final String? alcoholInteractionDescription;
  late final bool alcoholNteraction;
  late final List<Therapeutic> therapeuticList;

  Drug.fromJson(Map<String, dynamic> json){
    // print(1);
    name = json['name'];
    // print(2);
    pregnancyCategory = json['pregnancy_category'];
    // print(3);
    lactationCategory = json['lactation_category'];
    // print(4);
    instructions = json['instructions']??'';
    // print(5);
    // print(json['genric__id']);
    // print(json['genric_id']);
    genericId = json['genric__id']??json['genric_id'];
    // print(6);
    sideEffects = json['side_effects']??'';
    // print(7);
    howItWorks = json['how_it_works'];
    // print(8);
    therapeutic = json['therapeutic_class'];
    // print(9);
    usedFor = json['used_for'];
    // print(10);
    strength = json['strength'];
    // print(11);
    schedule = json['schedule'];
    // print(12);
    alcoholInteractionDescription = json['alcohol_interaction_description'];
    // print(13);
    alcoholNteraction = json['alcohol_nteraction'];
    // print(14);
    therapeuticList = List<Map<String ,dynamic>>.from(json['therapeuticClass']).map((e)=>Therapeutic.fromJson(e)).toList();
    // print(15);

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['pregnancy_category'] = pregnancyCategory;
    _data['lactation_category'] = lactationCategory;
    _data['instructions'] = instructions;
    _data['genric__id'] = genericId;
    _data['side_effects'] = sideEffects;
    _data['how_it_works'] = howItWorks;
    _data['therapeutic_class'] = therapeutic;
    _data['used_for'] = usedFor;
    _data['strength'] = strength;
    _data['schedule'] = schedule;
    _data['alcohol_interaction_description'] = alcoholInteractionDescription;
    _data['alcohol_nteraction'] = alcoholNteraction;
    _data['therapeuticClass'] = therapeuticList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Therapeutic {
  Therapeutic({
    // this.therapeutic,
    required this.name,
    required this.id,
    this.description,
  });
  // Therapeutic? therapeutic;
  late final String name;
  late final int id;
  late final dynamic description;

  Therapeutic.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    // therapeutic = Therapeutic.fromJson(json['therapeuticClass'];
    description = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['therapeuticClass'] = therapeutic!.toJson();
    _data['name'] = name;
    _data['id'] = id;
    _data['description'] = description;
    return _data;
  }
}