class Currency {
  int _id;
  String _ticker;
  double _value;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  String get ticker => _ticker;
  double get value => _value;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Currency(
      {int id,
      String ticker,
      double value,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _ticker = ticker;
    _value = value;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Currency.fromJson(dynamic json) {
    _id = json["id"];
    _ticker = json["ticker"];
    _value = json["value"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["ticker"] = _ticker;
    map["value"] = _value;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
