import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
    this.id,
    this.catName,});

  Category.fromJson(dynamic json) {
    id = json['id'];
    catName = json['Cat_name'];
  }
  num? id;
  String? catName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Cat_name'] = catName;
    return map;
  }

}