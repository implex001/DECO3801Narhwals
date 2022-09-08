import 'package:caravaneering/model/save_keys.dart';

class ItemDetails{
  static const horseKey = SaveKeysV1.horse;
  static const caravanKey = SaveKeysV1.caravan;
  static const petKey = SaveKeysV1.pet;

  static const coins = "coin";
  static const gems = "gem";

  static const coinImagePath = "assets/images/UI/CoinIcon.png";
  static const gemImagePath = "assets/images/UI/GemIcon.png";

  static const Map<String, Map<String, dynamic>> items = {
    "horse-yellow": {
      "key": "horse-yellow",
      "name": "Yellow horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-yellow.png",
      "description": "The best horse money can buy!",
    },
    "horse-dark-grey": {
      "key": "horse-dark-grey",
      "name": "Dark grey horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-dark-grey.png",
      "description": "The best horse money can buy!",
    },
    "horse-light-grey": {
      "key": "horse-light-grey",
      "name": "Light grey horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-light-grey.png",
      "description": "The best horse money can buy!",
    },
    "horse-blue": {
      "key": "horse-blue",
      "name": "Blue horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-blue.png",
      "description": "The best horse money can buy!",
    },
    "horse-dark-blue": {
      "key": "horse-dark-blue",
      "name": "Dark blue horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-dark-blue.png",
      "description": "The best horse money can buy!",
    },
    "horse-light-green": {
      "key": "horse-light-green",
      "name": "Light green horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-light-green.png",
      "description": "The best horse money can buy!",
    },
    "horse-dark-green": {
      "key": "horse-dark-green",
      "name": "Dark green horse",
      "type": horseKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-dark-green.png",
      "description": "The best horse money can buy!",
    },
    "horse-pink": {
      "key": "horse-pink",
      "name": "Pink horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": gems,
      "location": "assets/images/items/horse-pink.png",
      "description": "The best horse money can buy!",
    },
    "horse-purple": {
      "key": "horse-purple",
      "name": "Purple horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": gems,
      "location": "assets/images/items/horse-purple.png",
      "description": "The best horse money can buy!",
    },
    "cart1": {
      "key": "cart1",
      "name": "Cart level 1",
      "type": caravanKey,
      "cost": 10,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart1.png",
      "description": "Guess this counts as a cart...",
    },
    "cart2": {
      "key": "cart2",
      "name": "Cart level 2",
      "type": caravanKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart2.png",
      "description": "Best cart money can buy!",
    },
    "cart3": {
      "key": "cart3",
      "name": "Cart level 3",
      "type": caravanKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart3.png",
      "description": "Best cart money can buy!",
    },
    "cart4": {
      "key": "cart4",
      "name": "Cart level 4",
      "type": caravanKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart4.png",
      "description": "Best cart money can buy!",
    },
    "cart5": {
      "key": "cart5",
      "name": "Cart level 5",
      "type": caravanKey,
      "cost": 400,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart5.png",
      "description": "Best cart money can buy!",
    },
    "cart6": {
      "key": "cart6",
      "name": "Cart level 6",
      "type": caravanKey,
      "cost": 600,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart6.png",
      "description": "Best cart money can buy!",
    },
    "cart-purple": {
      "key": "cart-purple",
      "name": "Purple cart",
      "type": caravanKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart-purple.png",
      "description": "Best cart money can buy!",
    },
    "cart-blue": {
      "key": "cart-blue",
      "name": "Blue cart",
      "type": caravanKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cart-blue.png",
      "description": "Best cart money can buy!",
    },
    "cart-red": {
      "key": "cart-red",
      "name": "Red cart",
      "type": caravanKey,
      "cost": 400,
      "purchaseCurrency": gems,
      "location": "assets/images/items/cart-red.png",
      "description": "Best cart money can buy!",
    }
  };
}