import 'package:food_delivery/model/cart.dart';
import 'package:food_delivery/model/menu_item.dart';
import 'package:get_it/get_it.dart';

GetIt cart = GetIt.instance;

void setUpCart() {
  cart.registerLazySingleton(() => CartService());
}

class CartService {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addItemToCart(MenuItem menuItem, int quantity) {
    _cartItems.add(CartItem(
      menuItem: menuItem,
      quantity: quantity,
      price: menuItem.basePrice * quantity,
    ));
  }

  void editCartItemQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems[index].quantity = newQuantity;
      _cartItems[index].price =
          _cartItems[index].menuItem.basePrice * newQuantity;
    }
  }

  void removeCartItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}
