import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/shop/shop_items.dart';

/*
 * Creates an instance of the shop
 */
class Shop {
  // The current save
  SaveModel save;
  // The current shop items in the shop
  Map<String, List<String>> shopItems = {};
  // Which shop is currently being displayed
  String activeShop = ShopItems.defaultKey;

  Shop(this.save);

  // Gets a list of shop items between two index ranges
  List<String> getShopItems(int startIndex, int endIndex) {
    List<String> result = [];
    for (int i = startIndex - 1; i < endIndex; i++) {
      result.add(shopItems[activeShop]![i]);
    }
    return result;
  }

  // Populates all the items in the shop. Checks whether an item has already in
  // the save file and displays sold out image instead.
  // Note: Will throw a runtime exception is save is null
  void setUpItems() {
    for (String shopType in ShopItems.shopItemsDefaults.keys) {
      shopItems[shopType] = <String>[];
      for (int i = 0; i < ShopItems.shopItemsDefaults[shopType]!.length; i++) {
        String item = ShopItems.shopItemsDefaults[shopType]![i];
        if (save.checkIfHorseOwned(item)) {
          shopItems[shopType]!.add(ShopItems.shopSoldOutVisual[shopType]!);
        } else {
          shopItems[shopType]!.add(ShopItems.shopItemsDefaults[shopType]![i]);
        }
      }
    }
  }

  // Returns whether the item is sold out
  bool isItemAvailable(String type, String item) {
    if (item == ShopItems.shopSoldOutVisual[type]!) {
      return false;
    }
    return true;
  }

  // If the item can be bought, then adds item to save state and changes to the
  // sold out image.
  // Note: Will throw a runtime exception is save is null
  bool purchaseItem(String type, String item) {
    // If the item is sold out then return early
    if (!isItemAvailable(type, item)) {
      return false;
    }
    int purchaseIndex = shopItems[type]!.indexOf(item);
    shopItems[type]![purchaseIndex] = ShopItems.shopSoldOutVisual[type]!;
    switch (type) {
      // If it was a horse that was purchased, add horse to save
      case ShopItems.horseKey:
        save.addHorse(item);
        save.saveState();
        break;
      // If it was a XXX that was purchased, add XXX to save
      case ShopItems.diffKey:
        save.addHorse(item);
        save.saveState();
        break;
    }
    // The item was purchased
    return true;
  }
}