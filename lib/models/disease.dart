class Disease {
  Disease({
    required this.diseaseName,
    required this.diseaseCat,
    required this.diseaseInfo,
    required this.diseaseId,
    required this.searchScore,
  });
  late final String diseaseName;
  late final String diseaseCat;
  late final String diseaseInfo;
  late final String diseaseId;
  late final double searchScore;

  Disease.fromJson(Map<String, dynamic> json){
    diseaseName = json['disease_name'];
    diseaseCat = json['disease_cat'];
    diseaseInfo = json['disease_info'];
    diseaseId = json['disease_id'];
    searchScore = json['search_score'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['disease_name'] = diseaseName;
    _data['disease_cat'] = diseaseCat;
    _data['disease_info'] = diseaseInfo;
    _data['disease_id'] = diseaseId;
    _data['search_score'] = searchScore;
    return _data;
  }
}