import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class Subscription {
  int id;
  int userId;
  String name;
  int price;
  int renewalDay;
  int everyCount;
  String everyItem;
  String from;
  int notify;
  DateTime nextRenewal;
  String createdAt;
  String updatedAt;
  Widget image;

  Subscription(
      {int id,
      int userId,
      String name,
      int price,
      int renewalDay,
      int everyCount,
      String everyItem,
      String from,
      int notify,
      String nextRenewal,
      String createdAt,
      String updatedAt}) {
    this.nextRenewal = DateTime.parse(nextRenewal);
    this.image = Text('test');
    getImage();
  }

  Subscription.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    name = json["name"];
    price = json["price"];
    renewalDay = json["renewal_day"];
    everyCount = json["every_count"];
    everyItem = json["every_item"];
    from = json["from"];
    notify = json["notify"];
    nextRenewal = DateTime.parse(json["next_renewal"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["user_id"] = userId;
    map["name"] = name;
    map["price"] = price;
    map["renewal_day"] = renewalDay;
    map["every_count"] = everyCount;
    map["every_item"] = everyItem;
    map["from"] = from;
    map["notify"] = notify;
    map["next_renewal"] = nextRenewal;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    return map;
  }

  Widget getImage() {
    try {
      SvgPicture image = SvgPicture.asset('images/amazons.svg');
      this.image = image;
    } catch (e) {
      this.image = Text('test');
    }
  }
}
