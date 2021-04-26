class Data {
  int _id;
  int _userId;
  String _name;
  int _price;
  int _renewalDay;
  int _everyCount;
  String _everyItem;
  String _from;
  int _notify;
  String _createdAt;
  String _updatedAt;

  int get id => _id;
  int get userId => _userId;
  String get name => _name;
  int get price => _price;
  int get renewalDay => _renewalDay;
  int get everyCount => _everyCount;
  String get everyItem => _everyItem;
  String get from => _from;
  int get notify => _notify;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  set id(int newId) {
    this._id = newId;
  }

  set userId(int newUserId) {
    this._userId = newUserId;
  }

  set name(String newName) {
    this._name = newName;
  }

  set price(int newPrice) {
    this._price = newPrice;
  }

  set renewalDay(int newRenewalDay) {
    this._renewalDay = newRenewalDay;
  }

  set everyCount(int newEveryCount) {
    this._everyCount = newEveryCount;
  }

  set everyItem(String newEveryItem) {
    this._everyItem = newEveryItem;
  }

  set from(String newFrom) {
    this._from = newFrom;
  }

  set notify(int newNotify) {
    this._notify = newNotify;
  }

  set createdAt(String newCreatedAt) {
    this._createdAt = newCreatedAt;
  }

  set updatedAt(String newUpdatedAt) {
    this._updatedAt = newUpdatedAt;
  }

  Data(
      {int id,
      int userId,
      String name,
      int price,
      int renewalDay,
      int everyCount,
      String everyItem,
      String from,
      int notify,
      String createdAt,
      String updatedAt}) {
    _id = id;
    _userId = userId;
    _name = name;
    _price = price;
    _renewalDay = renewalDay;
    _everyCount = everyCount;
    _everyItem = everyItem;
    _from = from;
    _notify = notify;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _name = json["name"];
    _price = json["price"];
    _renewalDay = json["renewal_day"];
    _everyCount = json["every_count"];
    _everyItem = json["every_item"];
    _from = json["from"];
    _notify = json["notify"];
    _createdAt = json["created_at"];
    _updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["name"] = _name;
    map["price"] = _price;
    map["renewal_day"] = _renewalDay;
    map["every_count"] = _everyCount;
    map["every_item"] = _everyItem;
    map["from"] = _from;
    map["notify"] = _notify;
    map["created_at"] = _createdAt;
    map["updated_at"] = _updatedAt;
    return map;
  }
}
