import 'dart:convert';

import 'package:food_delivery/model/menu_item.dart';

class Menu {
  final int menuId;
  final String name;
  final String image;
  final DateTime createDate;
  final DateTime updateDate;
  final int status;
  final List<MenuItem> menuItems;

  const Menu({
    required this.menuId,
    required this.name,
    required this.image,
    required this.createDate,
    required this.updateDate,
    required this.status,
    required this.menuItems,
  });

  List<MenuItem> getItems(List jsonMenuItems) {
    return jsonMenuItems.map((menuItemJson) {
      return MenuItem.fromJson(menuItemJson as Map<String, dynamic>);
    }).toList();
  }

  factory Menu.fromJson(Map<String, dynamic> json) {
    // print(json['menuItems']);
    List jsonMenuItems = json['menuItems'] as List;
    // print("object");
    List<MenuItem> menuItems = jsonMenuItems.map((menuItemJson) {
      // print("kl");
      return MenuItem.fromJson(menuItemJson as Map<String, dynamic>);
    }).toList();
    // print(menuItems[0].image);
    return Menu(
      menuId: json['menu_id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      createDate: DateTime.parse(json['create_date'] as String),
      updateDate: DateTime.parse(json['update_date'] as String),
      status: json['status'] as int,
      menuItems: menuItems,
    );
  }
}
