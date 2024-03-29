import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/items_details.dart';
import 'package:caravaneering/model/shop/shop.dart';
import 'package:caravaneering/views/overlays/navbar_overlay.dart';
import 'package:caravaneering/views/shop/shop_shelf.dart';
import 'package:caravaneering/views/shop/shop_nav.dart';
import 'package:caravaneering/views/shop/shop_description_panel.dart';
import 'package:caravaneering/views/shop/shop_purchase_confirmation.dart';

/// View of the item shop
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
  static const String blankPanelImage =
      "assets/images/shop/bg-item-descript.png";
  static const double navImageRatio = (72 / 41);

  // The different menu icon hotspots on the right side of the shop
  Map<String, List<double>> menuItems = {};

  // The instance of the shop
  Shop? shop;

  // Dimensions of the navigation image
  double navImageHeight = 0;
  double navImageWidth = 0;

  // Whether the item description is currently shown
  bool showItemDescription = false;

  // What panel is being displayed in the top right corner
  String topRightPanelImage = shopKeeperImage;

  // What item is currently being shown in the item description panel
  Map<String, dynamic> itemShowing = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Set the navigation image dimensions
    if (navImageHeight == 0) {
      navImageHeight = 2 * (MediaQuery.of(context).size.height / 5);
      navImageWidth = navImageHeight * navImageRatio;

      calculateHotspots();
    }
    // Initialise the shop
    if (shop == null) {
      shop = Shop(Provider.of<SaveModel>(context, listen: true));
      shop!.setUpItems();
    }
  }

  // Calculates the click hotspots for the shop navigation
  void calculateHotspots() {
    int largeShieldBufferX = 25;
    int largeShieldBufferY = 35;

    // The different menu icon hotspots on the right side of the shop
    menuItems = {
      // List elements are: X coord1, Y coord1, X coord2, Y coord2
      ItemDetails.horseKey: [
        navImageWidth / 5.04 - largeShieldBufferX,
        navImageHeight / 2.05 - largeShieldBufferY,
        navImageWidth / 5.04 + largeShieldBufferX,
        navImageHeight / 2.05 + largeShieldBufferY
      ],
      ItemDetails.cartKey: [
        navImageWidth / 1.87 - largeShieldBufferX,
        navImageHeight / 2.05 - largeShieldBufferY,
        navImageWidth / 1.87 + largeShieldBufferX,
        navImageHeight / 2.05 + largeShieldBufferY
      ],
      ItemDetails.petKey: [
        navImageWidth / 1.16 - largeShieldBufferX,
        navImageHeight / 2.05 - largeShieldBufferY,
        navImageWidth / 1.16 + largeShieldBufferX,
        navImageHeight / 2.05 + largeShieldBufferY
      ],
    };
  }

  // Check what coordinates were clicked on. If clicked on a shop icon then switch
  // to that shop type
  void onTapShopMenuItem(TapDownDetails details) {
    if (shop == null) {
      return;
    }
    double x = details.localPosition.dx;
    double y = details.localPosition.dy;

    // Check through all the menu coordinates
    for (String type in menuItems.keys) {
      List<double> coordBounds = menuItems[type]!;
      // If the click was within the coordinate boundaries then switch to that
      // shop type
      if (x > coordBounds[x1] &&
          x < coordBounds[x2] &&
          y > coordBounds[y1] &&
          y < coordBounds[y2]) {

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

  // When an item is clicked it shows/removes the description panel
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
  void purchaseItem() {
    if (shop == null) {
      return;
    }

    setState(() {
      if (shop!.purchaseItem(shop!.activeShop, itemShowing)) {
        itemShowing = {};
        showItemDescription = false;
        topRightPanelImage = shopKeeperImage;
      }
    });
  }

  // Pop up window to confirm the purchase
  Future<void> confirmPurchase() async {
    if (shop == null) {
      return;
    }

    bool enoughCurrency = false;
    // If don't have enough currency return false
    if (itemShowing["purchaseCurrency"] == ItemDetails.gems) {
      if (shop!.save.get(SaveKeysV1.gems) >= itemShowing["cost"]) {
        enoughCurrency = true;
      }
    } else {
      if (shop!.save.get(SaveKeysV1.coins) >= itemShowing["cost"]) {
        enoughCurrency = true;
      }
    }

    PurchaseConfirmationPage.showPage(
        context, enoughCurrency, itemShowing, purchaseItem);
  }

  @override
  Widget build(BuildContext context) {
    // If data was erased then refresh shop
    if (shop != null && shop!.save.hasErasedData) {
      shop!.setUpItems();
      shop!.save.hasErasedData = false;
    }

    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Center(
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
                      )),
                      child: Column(
                        children: [
                          Image.asset('assets/images/shop/bg-rack-top-bar.png'),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/shop/bg-rack-ropes.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 40),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      (shop == null)
                                          ? Container()
                                          : ShopShelf(
                                              items: shop!.getShopItems(1, 3),
                                              shopingItem: itemShowing,
                                              itemClickFunction: itemClicked,
                                            ),
                                      (shop == null)
                                          ? Container()
                                          : ShopShelf(
                                              items: shop!.getShopItems(4, 6),
                                              shopingItem: itemShowing,
                                              itemClickFunction: itemClicked,
                                            ),
                                      (shop == null)
                                          ? Container()
                                          : ShopShelf(
                                              items: shop!.getShopItems(7, 9),
                                              shopingItem: itemShowing,
                                              itemClickFunction: itemClicked,
                                            ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ))),
              Column(children: [
                Expanded(
                  child: Container(
                    width: navImageWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(topRightPanelImage),
                      fit: BoxFit.cover,
                    )),
                    child: (!showItemDescription)
                        ? null
                        : ShopDescriptionPanel(
                            item: itemShowing,
                            purchase: confirmPurchase,
                          ),
                  ),
                ),
                ShopNav(
                  navImageHeight: navImageHeight,
                  navImageWidth: navImageWidth,
                  onTapFunction: onTapShopMenuItem,
                  shopType:
                      (shop == null) ? ItemDetails.horseKey : shop!.activeShop,
                ),
              ])
            ],
          ),
        ),
      ),
      const NavBar(),
    ]);
  }
}
