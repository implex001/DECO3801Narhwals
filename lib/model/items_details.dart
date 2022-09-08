import 'package:caravaneering/model/save_keys.dart';

class ItemDetails{
  static const horseKey = SaveKeysV1.horse;
  static const caravanKey = SaveKeysV1.caravan;
  static const coinKey = "coin";
  static const petKey = SaveKeysV1.pet;
  static const weaponKey = SaveKeysV1.weapon;
  static const accessoryKey = SaveKeysV1.accessory;

  static const coins = "coin";
  static const gems = "gem";

  static const coinImagePath = "assets/images/UI/CoinIcon.png";
  static const gemImagePath = "assets/images/UI/GemIcon.png";

  static const Map<String, Map<String, dynamic>> items = {
    "horse-yellow": {
      "key": "horse-yellow",
      "name": "Yellow horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-yellow.png",
      "description": "The best horse money can buy!",
    },
    "horse-dark-grey": {
      "key": "horse-dark-grey",
      "name": "Dark grey horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-dark-grey.png",
      "description": "The best horse money can buy!",
    },
    "horse-light-grey": {
      "key": "horse-light-grey",
      "name": "Light grey horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-light-grey.png",
      "description": "The best horse money can buy!",
    },
    "horse-blue": {
      "key": "horse-blue",
      "name": "Blue horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-blue.png",
      "description": "The best horse money can buy!",
    },
    "horse-dark-blue": {
      "key": "horse-dark-blue",
      "name": "Dark blue horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-dark-blue.png",
      "description": "The best horse money can buy!",
    },
    "horse-light-green": {
      "key": "horse-light-green",
      "name": "Light green horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-light-green.png",
      "description": "The best horse money can buy!",
    },
    "horse-dark-green": {
      "key": "horse-dark-green",
      "name": "Dark green horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-dark-green.png",
      "description": "The best horse money can buy!",
    },
    "horse-pink": {
      "key": "horse-pink",
      "name": "Pink horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": gems,
      "location": "assets/images/shop/horse-pink.png",
      "description": "The best horse money can buy!",
    },
    "horse-purple": {
      "key": "horse-purple",
      "name": "Purple horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/shop/horse-purple.png",
      "description": "The best horse money can buy!",
    },
  };
}