class Data {
  String _name;
  int _userId;
  String _price;
  String _renewalDay;
  String _everyCount;
  String _everyItem;
  String _from;
  String _updatedAt;
  String _createdAt;
  int _id;

  String get name => _name;
  int get userId => _userId;
  String get price => _price;
  String get renewalDay => _renewalDay;
  String get everyCount => _everyCount;
  String get everyItem => _everyItem;
  String get from => _from;
  String get updatedAt => _updatedAt;
  String get createdAt => _createdAt;
  int get id => _id;

  Data(
      {String name,
      int userId,
      String price,
      String renewalDay,
      String everyCount,
      String everyItem,
      String from,
      String updatedAt,
      String createdAt,
      int id}) {
    _name = name;
    _userId = userId;
    _price = price;
    _renewalDay = renewalDay;
    _everyCount = everyCount;
    _everyItem = everyItem;
    _from = from;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
  }

  Data.fromJson(dynamic json) {
    _name = json["name"];
    _userId = json["user_id"];
    _price = json["price"];
    _renewalDay = json["renewal_day"];
    _everyCount = json["every_count"];
    _everyItem = json["every_item"];
    _from = json["from"];
    _updatedAt = json["updated_at"];
    _createdAt = json["created_at"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["user_id"] = _userId;
    map["price"] = _price;
    map["renewal_day"] = _renewalDay;
    map["every_count"] = _everyCount;
    map["every_item"] = _everyItem;
    map["from"] = _from;
    map["updated_at"] = _updatedAt;
    map["created_at"] = _createdAt;
    map["id"] = _id;
    return map;
  }
}
