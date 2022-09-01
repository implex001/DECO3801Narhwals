import 'package:flutter/material.dart';

import 'package:caravaneering/model/shop/shop.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/shop/shop_items.dart';
import 'package:caravaneering/views/shop/shop_shelf.dart';
import 'package:caravaneering/views/shop/shop_nav.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopState();
}

class _ShopState extends State<ShopView> {

  static const int x1 = 0;
  static const int y1 = 1;
  static const int x2 = 2;
  static const int y2 = 3;

  static const Map<String, List<int>> menuItems = {
    // List elements are: X coord1, Y coord1, X coord2, Y coord2
    ShopItems.horseKey: [0, 0, 200, 175],
    ShopItems.diffKey: [0, 175, 200, 250],
  };

  SaveModel? save;
  Shop shop = Shop();

  @override
  void initState() {
    super.initState();
    shop.activeShop = ShopItems.horseKey;
    shop.setItemsToLoading();
    if (save == null) {
      save = SaveModel();
      shop.save = save;
      save?.init().then((s) {
        setState(() {
          shop.setUpItems();
        });
      });
    } else {
      shop.save = save;
      shop.setUpItems();
    }
  }

  void purchaseFunction(String type, String item) {
    setState(() {
      shop.purchaseItem(type, item);
    });
  }

  void onTapShopMenuItem(TapDownDetails details) {
    double x = details.localPosition.dx;
    double y = details.localPosition.dy;

    print("Tap coordinates are: $x, $y");
    for (String type in menuItems.keys) {
      List<int> coordBounds = menuItems[type]!;
      if (x > coordBounds[x1] && x < coordBounds[x2] &&
          y > coordBounds[y1] && y < coordBounds[y2]) {
        print("Shop tab $type selected!");
        shop.activeShop = type;
        setState(() {
          shop.setItemsToLoading();
          shop.setUpItems();
        });
      }
    }
  }

  void temporaryFunctionDeleteSaveData() async {
    await save?.eraseSave();
    setState(() {
      shop.setItemsToLoading();
      shop.setUpItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            title: const Text("GAME MENU WILL GO HERE"),
            backgroundColor: Colors.orange[200],
        )
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/shop/bg-curtain.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                child: Column(
                  children: [
                    Image.asset('assets/images/shop/bg-rack-top-bar.png'),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/shop/bg-rack-ropes.png'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ShopShelf(
                                type: shop.activeShop,
                                items: shop.getShopItems(1, 3),
                                purchaseFunction: purchaseFunction,
                              ),
                              ShopShelf(
                                type: shop.activeShop,
                                items: shop.getShopItems(4, 6),
                                purchaseFunction: purchaseFunction,
                              ),
                              ShopShelf(
                                type: shop.activeShop,
                                items: shop.getShopItems(7, 9),
                                purchaseFunction: purchaseFunction,
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ),
            ShopNav(onTapFunction: onTapShopMenuItem),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          temporaryFunctionDeleteSaveData();
          },
        tooltip: 'Erase Save',
        child: const Icon(Icons.recycling),
      ),
    );
  }
}
