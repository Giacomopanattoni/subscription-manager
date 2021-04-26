import 'data_model.dart';

class Subscription {
  String _status;
  Data _data;

  String get status => _status;
  Data get data => _data;

  set data(Data newData) {
    this._data = newData;
  }

  Subscription({String status, Data data}) {
    _status = status;
    _data = data;
  }

  Subscription.fromJson(dynamic json) {
    _status = json["status"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    return map;
  }
}
