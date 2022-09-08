import 'package:caravaneering/model/items_details.dart';

class ShopItems{

  // A key name for each shop type used to access different dictionaries. This
  // text should not be displayed anywhere on the app

  static const defaultKey = ItemDetails.horseKey;

  // The sold out image relating to each shop type
  static const Map<String, Map<String, dynamic>> shopSoldOutVisual = {
    ItemDetails.horseKey: {
      "name": "Sold Out!",
      "type": ItemDetails.horseKey,
      "location": "assets/images/shop/horse-sold-out.png",
    },
    ItemDetails.cartKey: {
      "name": "Sold Out!",
      "type": ItemDetails.cartKey,
      "location": "assets/images/shop/cart-sold-out.png",
    },
    ItemDetails.petKey: {
      "name": "Sold Out!",
      "type": ItemDetails.petKey,
      "location": "assets/images/shop/horse-sold-out.png",
    },
  };

  // The current items in the shop for each shop type
  static Map<String, List<Map<String, dynamic>>> shopItemsDefaults = {
    ItemDetails.horseKey: [
      ItemDetails.items["horse-yellow"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-dark-grey"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-light-grey"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-blue"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-dark-blue"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-light-green"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-dark-green"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-pink"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-purple"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
    ],
    ItemDetails.cartKey: [
      ItemDetails.items["cart1"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart2"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart3"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart4"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart5"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart6"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart-purple"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart-blue"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
      ItemDetails.items["cart-red"] ?? shopSoldOutVisual[ItemDetails.cartKey]!,
    ],
    ItemDetails.petKey: [
      ItemDetails.items["horse-pink"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-light-grey"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-dark-grey"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-dark-green"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-dark-blue"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-purple"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-yellow"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-light-green"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
      ItemDetails.items["horse-blue"] ?? shopSoldOutVisual[ItemDetails.horseKey]!,
    ],
  };


}