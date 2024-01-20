import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/common/cart.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/model/cart.dart';
import 'package:food_delivery/model/menu.dart';
import 'package:http/http.dart' as http;

import '../../common/color_extension.dart';
import '../../common_widget/round_textfield.dart';
import '../more/my_order_view.dart';
import 'menu_items_view.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  late Future<List<Menu>> futureMenus;
  // List menuArr = [
  //   {
  //     "name": "Plat",
  //     "image": "assets/img/menu_1.png",
  //     "items_count": "120",
  //   },
  //   {
  //     "name": "Boissons",
  //     "image": "assets/img/menu_2.png",
  //     "items_count": "220",
  //   },
  //   {
  //     "name": "Desserts",
  //     "image": "assets/img/menu_3.png",
  //     "items_count": "155",
  //   },
  //   {
  //     "name": "Promotions",
  //     "image": "assets/img/menu_4.png",
  //     "items_count": "25",
  //   },
  // ];
  TextEditingController txtSearch = TextEditingController();

  Future<List<Menu>> fetchMenus() async {
    final response = await http.get(Uri.parse(
        '${SVKey.baseUrl}/menu')); // Replace with your actual API endpoint

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response,
      // then parse the JSON array and return a list of Menu objects.
      final List<dynamic> menuList = jsonDecode(response.body);

      return menuList.map((menuJson) {
        print(menuJson.runtimeType);
        return Menu.fromJson(menuJson as Map<String, dynamic>);
      }).toList();
    } else {
      // If the server does not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load menus');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMenus = fetchMenus();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    CartService cartService = cart<CartService>();
    List<CartItem> cartItems = cartService.cartItems;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 180),
            width: media.width * 0.27,
            height: media.height * 0.6,
            decoration: BoxDecoration(
              color: TColor.primary,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 46,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Menu",
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                        Badge(
                          label: cartItems.isNotEmpty
                              ? Text(cartItems.length.toString())
                              : null,
                          backgroundColor:
                              cartItems.isEmpty ? TColor.white : TColor.primary,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyOrderView()));
                            },
                            icon: Image.asset(
                              "assets/img/shopping_cart.png",
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundTextfield(
                      hintText: "Rechercher Plat",
                      controller: txtSearch,
                      left: Container(
                        alignment: Alignment.center,
                        width: 30,
                        child: Image.asset(
                          "assets/img/search.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder<List<Menu>>(
                      future: futureMenus,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: ((context, index) {
                                var mObj = snapshot.data![index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MenuItemsView(
                                          mObj: mObj,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 8, bottom: 8, right: 20),
                                        width: media.width - 100,
                                        height: 90,
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(25),
                                                bottomLeft: Radius.circular(25),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 4))
                                            ]),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            mObj.image,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  mObj.name,
                                                  style: TextStyle(
                                                      color: TColor.primaryText,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  "${mObj.menuItems.length.toString()} articles",
                                                  style: TextStyle(
                                                      color:
                                                          TColor.secondaryText,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(17.5),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 4,
                                                      offset: Offset(0, 2))
                                                ]),
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              "assets/img/btn_next.png",
                                              width: 15,
                                              height: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }));
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
