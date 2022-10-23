class DrugInteraction {
  DrugInteraction({
    required this.generic,
    required this.interactions,
  });
  late final String generic;
  late final List<Interactions> interactions;

  DrugInteraction.fromJson(Map<String, dynamic> json){
    generic = json['generic'];
    interactions = List.from(json['interactions']).map((e)=>Interactions.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['generic'] = generic;
    _data['interactions'] = interactions.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Interactions {
  Interactions({
    required this.items,
    required this.severity,
    required this.description,
    required this.source,
  });
  late final List<Items> items;
  late final String severity;
  late final String description;
  late final String source;

  Interactions.fromJson(Map<String, dynamic> json){
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    severity = json['severity'];
    description = json['description'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['severity'] = severity;
    _data['description'] = description;
    _data['source'] = source;
    return _data;
  }
}

class Items {
  Items({
    required this.name,
  });
  late final String name;

  Items.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    return _data;
  }
}