class Quotes{
  Quotes({
    required this.quote,
    required this.author,
    required this.header,
  });
  late final String quote;
  late final String author;
  late final String header;

  Quotes.fromJson(Map<String, dynamic> json){
    quote = json['q'];
    author = json['a'];
    header = json['h'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['q'] = quote;
    _data['a'] = author;
    _data['h'] = header;
    return _data;
  }
}