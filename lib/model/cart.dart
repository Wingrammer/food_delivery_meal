import 'package:food_delivery/model/menu_item.dart';

class CartItem {
  MenuItem menuItem;
  int quantity;
  double price;

  CartItem(
      {required this.menuItem, required this.quantity, required this.price});
}
