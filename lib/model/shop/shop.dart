import 'package:caravaneering/model/items_details.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/shop/shop_items.dart';

/// Creates an instance of the shop
class Shop {
  // The current save
  SaveModel save;

  // The current shop items in the shop
  Map<String, List<Map<String, dynamic>>> shopItems = {};

  // Which shop is currently being displayed
  String activeShop = ShopItems.defaultKey;

  Shop(this.save);

  /// Gets a list of shop items between two index ranges
  List<Map<String, dynamic>> getShopItems(int startIndex, int endIndex) {
    List<Map<String, dynamic>> result = [];
    for (int i = startIndex - 1; i < endIndex; i++) {
      result.add(shopItems[activeShop]![i]);
    }
    return result;
  }

  /// Populates all the items in the shop. Checks whether an item has already in
  /// the save file and displays sold out image instead.
  /// Note: Will throw a runtime exception is save is null
  void setUpItems() {
    for (String shopType in ShopItems.shopItemsDefaults.keys) {
      shopItems[shopType] = <Map<String, dynamic>>[];
      for (int i = 0; i < ShopItems.shopItemsDefaults[shopType]!.length; i++) {
        Map<String, dynamic> item = ShopItems.shopItemsDefaults[shopType]![i];
        if (save.checkIfItemOwned(item)) {
          shopItems[shopType]!.add(ShopItems.shopSoldOutVisual[shopType]!);
        } else {
          shopItems[shopType]!.add(ShopItems.shopItemsDefaults[shopType]![i]);
        }
      }
    }
  }

  /// Returns whether the item is sold out
  bool isItemAvailable(Map<String, dynamic> item) {
    String type = item["type"];
    if (item["name"] == ShopItems.shopSoldOutVisual[type]!["name"]) {
      return false;
    }
    return true;
  }

  /// If the item can be bought, then adds item to save state and changes to the
  /// sold out image.
  /// Note: Will throw a runtime exception is save is null
  bool purchaseItem(String storeType, Map<String, dynamic> item) {
    // If the item is sold out then return early
    if (!isItemAvailable(item)) {
      return false;
    }

    int purchaseIndex = shopItems[storeType]!.indexOf(item);
    shopItems[storeType]![purchaseIndex] =
        ShopItems.shopSoldOutVisual[item["type"]]!;
    save.addItem(item);
    if (item["purchaseCurrency"] == ItemDetails.gems) {
      save.removeGems(item["cost"]);
    } else {
      save.removeCoins(item["cost"]);
    }
    save.saveState();

    if (item["type"] == SaveKeysV1.horses) {
      save.equipHorse(1, item["key"]);
    }
    if (item["type"] == SaveKeysV1.carts) {
      save.equipCart(1, item["key"]);
    }
    if (item["type"] == SaveKeysV1.pets) {
      save.equipPet(1, item["key"]);
    }

    // The item was purchased
    return true;
  }
}
