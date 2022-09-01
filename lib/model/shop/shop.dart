import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/shop/shop_items.dart';

class Shop {

  SaveModel? save;
  Map<String, List<String>> shopItems = {};
  String activeShop = "";

  List<String> getShopItems(int startIndex, int endIndex) {
    List<String> result = [];
    for (int i = startIndex - 1; i < endIndex; i++) {
      result.add(shopItems[activeShop]![i]);
    }
    return result;
  }

  void setItemsToLoading() {
    for (String shopType in ShopItems.shopItemsDefaults.keys) {
      shopItems[shopType] = [];
      for (int i = 0; i < ShopItems.shopItemsDefaults[shopType]!.length; i++) {
        shopItems[shopType]!.add("loading-item.png");
      }
    }
  }

  void setUpItems() {
    for (String shopType in ShopItems.shopItemsDefaults.keys) {
      for (int i = 0; i < ShopItems.shopItemsDefaults[shopType]!.length; i++) {
        String horse = ShopItems.shopItemsDefaults[shopType]![i];
        if (save!.checkIfHorseOwned(horse)) {
          shopItems[shopType]![i] = ShopItems.shopSoldOutVisual[shopType]!;
        } else {
          shopItems[shopType]![i] = ShopItems.shopItemsDefaults[shopType]![i];
        }
      }
    }
  }

  void purchaseItem(String type, String item) {
    // If the item is sold out then return early
    if (item == ShopItems.shopSoldOutVisual[type]!) {
      return;
    }
    int purchaseIndex = shopItems[type]!.indexOf(item);
    shopItems[type]![purchaseIndex] = ShopItems.shopSoldOutVisual[type]!;
    switch (type) {
      case ShopItems.horseKey:
        if (save != null) {
          save?.addHorse(item);
          save?.saveState();
        }
        break;
      case ShopItems.diffKey:
        if (save != null) {
          save?.addHorse(item);
          save?.saveState();
        }
        break;
    }
  }
}