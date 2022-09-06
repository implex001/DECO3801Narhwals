import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:caravaneering/model/items_details.dart';
import 'package:caravaneering/model/shop/shop.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/shop/shop_items.dart';
import 'package:caravaneering/views/shop/shop_shelf.dart';
import 'package:caravaneering/views/shop/shop_nav.dart';


/*
 * Creates the shop page
 */
class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopState();
}

class _ShopState extends State<ShopView> {

  // Used in indexing lists for code readability
  static const int x1 = 0;
  static const int y1 = 1;
  static const int x2 = 2;
  static const int y2 = 3;
  static const String shopKeeperImage = "assets/images/shop/bg-shop-person.png";
  static const String blankPanelImage = "assets/images/shop/bg-item-descript.png";
  static const double navImageRatio = (72/41);

  // The different menu icon hotspots on the right side of the shop
  static const Map<String, List<int>> menuItems = {
    // List elements are: X coord1, Y coord1, X coord2, Y coord2
    ItemDetails.horseKey: [0, 0, 200, 175],
    ItemDetails.diffKey: [0, 175, 200, 250],
  };

  // The instance of the shop
  Shop? shop;

  // Dimensions of the navigation image
  double navImageHeight = 0;
  double navImageWidth = 0;

  bool showItemDescription = false;
  String topRightPanelImage = shopKeeperImage;
  Map<String, dynamic> itemShowing = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the navigation image dimensions
    if (navImageHeight == 0) {
      navImageHeight = 2 * (MediaQuery.of(context).size.height/5);
      navImageWidth = navImageHeight * navImageRatio;
    }
    // Initialise the shop
    if (shop == null) {
      shop = Shop(Provider.of<SaveModel>(context));
      shop!.setUpItems();
    }
  }


  void itemClicked(Map<String, dynamic> item) {
    if (shop == null) {
      return;
    }
    if (!shop!.isItemAvailable(item)) {
      return;
    }
    setState(() {
      if (itemShowing == item) {
        itemShowing = {};
        showItemDescription = false;
        topRightPanelImage = shopKeeperImage;
      } else {
        itemShowing = item;
        showItemDescription = true;
        topRightPanelImage = blankPanelImage;
      }
    });
  }
  
  // Attempts to purchase an item
  void purchaseItem(Map<String, dynamic> item) {
    if (shop == null) {
      return;
    }
    setState(() {
      if (shop!.purchaseItem(item)) {
        itemShowing = {};
        showItemDescription = false;
        topRightPanelImage = shopKeeperImage;
      }
    });
  }

  // Check what coordinates were clicked on. If clicked on a shop icon then switch
  // to that shop type
  void onTapShopMenuItem(TapDownDetails details) {
    if (shop == null) {
      return;
    }

    double x = details.localPosition.dx;
    double y = details.localPosition.dy;

    print("Tap coordinates are: $x, $y");
    // Check through all the menu coordinates
    for (String type in menuItems.keys) {
      List<int> coordBounds = menuItems[type]!;
      // If the click was within the coordinate boundaries then switch to that
      // shop type
      if (x > coordBounds[x1] && x < coordBounds[x2] &&
          y > coordBounds[y1] && y < coordBounds[y2]) {
        print("Shop tab $type selected!");
        // Setup the items for the new shop type
        shop!.activeShop = type;
        itemShowing = {};
        showItemDescription = false;
        setState(() {
          topRightPanelImage = shopKeeperImage;
          shop!.setUpItems();
        });
      }
    }
  }

  // DELETE before release. This function is to test out deleting the save data
  void temporaryFunctionDeleteSaveData() async {
    if (shop == null) {
      return;
    }
    await shop!.save.eraseSave();
    setState(() {
      shop!.setUpItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            title: const Text("GAME MENU WILL GO HERE"),
            backgroundColor: Colors.orange[200],
            actions: [
              TextButton(
                  onPressed: () {
                    temporaryFunctionDeleteSaveData();
                  },
                  child: Text("Delete Save")
              ),
            ]
          )
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
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
                        decoration: const BoxDecoration(
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
                              (shop == null) ? Container() : ShopShelf(
                                items: shop!.getShopItems(1, 3),
                                itemClickFunction: itemClicked,
                              ),
                              (shop == null) ? Container() : ShopShelf(
                                items: shop!.getShopItems(4, 6),
                                itemClickFunction: itemClicked,
                              ),
                              (shop == null) ? Container() : ShopShelf(
                                items: shop!.getShopItems(7, 9),
                                itemClickFunction: itemClicked,
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
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: navImageWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(topRightPanelImage),
                          fit: BoxFit.cover,
                        )
                    ),
                    child: (!showItemDescription) ? null : ItemDescriptionPanel(
                      item: itemShowing,
                      purchase: purchaseItem,
                    ),
                  ),
                ),
                ShopNav(navImageHeight: navImageHeight, navImageWidth: navImageWidth, onTapFunction: onTapShopMenuItem),
              ]
            )

          ],
        ),
      ),
    );
  }
}

class ItemDescriptionPanel extends StatelessWidget {
  const ItemDescriptionPanel({Key? key, required this.item, required this.purchase}) : super(key: key);

  // The item to display
  final Map<String, dynamic> item;
  final Function purchase;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage(item["location"]),
          height: 65,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          item["description"],
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(120, 40)),
            backgroundColor: MaterialStateProperty.all(Colors.brown[400]),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Text(
                item["cost"].toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image(
                image: AssetImage(item["purchaseCurrency"]),
                height: 30,
              ),
            ],
          ),
          onPressed: () {purchase(item);},
        )
      ],
    );
  }
}

