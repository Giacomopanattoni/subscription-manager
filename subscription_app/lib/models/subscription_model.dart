import 'package:flutter/material.dart';
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
  bool notify;
  String color;
  int categoryId;
  String image;
  DateTime nextRenewal;
  String createdAt;
  String updatedAt;

  Subscription(
      {int id,
      int userId,
      String name,
      int price,
      int renewalDay,
      int everyCount,
      String everyItem,
      String from,
      bool notify,
      String color,
      int categoryId,
      String nextRenewal,
      String createdAt,
      String updatedAt});

  Subscription.fromJson(dynamic json) {
    id = json["id"];
    userId = json["user_id"];
    name = json["name"];
    price = json["price"];
    renewalDay = json["renewal_day"];
    everyCount = json["every_count"];
    everyItem = json["every_item"];
    from = json["from"];
    notify = json["notify"] == 1;
    color = json["color"];
    categoryId = json["category_id"];
    image = json["image"];
    nextRenewal = DateTime.parse(json["next_renewal"]);
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "price": price,
        "renewal_day": renewalDay,
        "every_count": everyCount,
        "every_item": everyItem,
        "from": from,
        "notify": notify,
        "color": color,
        "category_id": categoryId,
        "image": image,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "next_renewal": nextRenewal.toString().split(' ')[0]
      };

  Widget getImage() {
    if (image != null) {
      return SvgPicture.asset('images/' + image + '.svg');
    }
    return Text(name[0]);
  }
}
