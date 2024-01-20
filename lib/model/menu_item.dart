class MenuItem {
  final int menuItemId;
  final int menuId;
  final int restaurantId;
  final int categoryId;
  final String foodType;
  final String oneTwo;
  final String? image;
  final bool isPortionAllow;
  final bool isCustomIngredientAllow;
  final String description;
  final double basePrice;
  final DateTime createDate;
  final DateTime updateDate;
  final int status;
  final String menuItemName; // Added field
  final int rate; // Added field
  final int rating; // Added field
  final String type; // Added field

  MenuItem({
    required this.menuItemId,
    required this.menuId,
    required this.restaurantId,
    required this.categoryId,
    required this.foodType,
    required this.oneTwo,
    required this.image,
    required this.isPortionAllow,
    required this.isCustomIngredientAllow,
    required this.description,
    required this.basePrice,
    required this.createDate,
    required this.updateDate,
    required this.status,
    required this.menuItemName,
    required this.rate,
    required this.rating,
    required this.type,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      menuItemId: json['menu_item_id'] as int,
      menuId: json['menu_id'] as int,
      restaurantId: json['restaurant_id'] as int,
      categoryId: json['category_id'] as int,
      foodType: json['food_type'] as String,
      oneTwo: json['one_two'] as String,
      image: json['image'] as String?,
      isPortionAllow: json['is_portion_allow'] as bool,
      isCustomIngredientAllow: json['is_custom_ingredient_allow'] as bool,
      description: json['description'] as String,
      basePrice: json['base_price'] as double,
      createDate: DateTime.parse(json['create_date'] as String),
      updateDate: DateTime.parse(json['update_date'] as String),
      status: json['status'] as int,
      menuItemName: json['name'] as String,
      rate: json['rate'] is int
          ? json['rate'] as int
          : int.parse(json['rate'] as String),
      rating: json['rating'] is int
          ? json['rating'] as int
          : int.parse(json['rating'] as String),
      type: json['type'] as String,
    );
  }
}
