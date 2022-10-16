import 'package:caravaneering/model/save_keys.dart';
import 'package:global_configuration/global_configuration.dart';

/// Shop item specifics
class ItemDetails {
  static const String horseKey = SaveKeysV1.horses;
  static const String cartKey = SaveKeysV1.carts;
  static const String petKey = SaveKeysV1.pets;

  static const String coins = "coin";
  static const String gems = "gem";

  static const String coinImagePath = "assets/images/UI/CoinIcon.png";
  static const String gemImagePath = "assets/images/UI/GemIcon.png";

  static List<dynamic> startingHorses =
      Map.from(GlobalConfiguration().getValue("stateDefaults"))[
          SaveKeysV1.equippedHorses];
  static List<dynamic> startingCarts =
      Map.from(GlobalConfiguration().getValue("stateDefaults"))[
          SaveKeysV1.equippedCarts];
  static List<dynamic> startingPets = Map.from(
      GlobalConfiguration().getValue("stateDefaults"))[SaveKeysV1.equippedPets];

  static const Map<String, Map<String, dynamic>> items = {
    "horse-brown": {
      "key": "horse-brown",
      "name": "Brown horse",
      "type": horseKey,
      "cost": 0,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-brown.png",
      "description": "This is the starter horse",
    },
    "horse-tan": {
      "key": "horse-tan",
      "name": "Tan horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-tan.png",
      "description": "A nice tan horse but not a horse with a tan.",
    },
    "horse-black": {
      "key": "horse-black",
      "name": "Black horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-black.png",
      "description": "As dark as a shadow, good luck finding it at night!",
    },
    "horse-grey": {
      "key": "horse-grey",
      "name": "Grey horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-grey.png",
      "description": "This old grey mare ain't what she used to be.",
    },
    "horse-cream": {
      "key": "horse-cream",
      "name": "Cream horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-cream.png",
      "description": "This horse might just be the cream of the crop. "
          "Or at least the cream of some crop.",
    },
    "horse-red": {
      "key": "horse-red",
      "name": "Red horse",
      "type": horseKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-red.png",
      "description": "I've heard painting things red makes them go faster? "
          "Only one way to find out!",
    },
    "horse-white": {
      "key": "horse-white",
      "name": "White horse",
      "type": horseKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/horse-white.png",
      "description": "A regal horse from a more noble time.",
    },
    "horse-green": {
      "key": "horse-green",
      "name": "Green horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": gems,
      "location": "assets/images/items/horse-green.png",
      "description": "The closest to camouflage you can find, blends right in"
          "with the leaves and the trees!",
    },
    "horse-blue": {
      "key": "horse-blue",
      "name": "Blue horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": gems,
      "location": "assets/images/items/horse-blue.png",
      "description": "A stern blue horse to go with your look of blue steel.",
    },
    "horse-purple": {
      "key": "horse-purple",
      "name": "Purple horse",
      "type": horseKey,
      "cost": 50,
      "purchaseCurrency": gems,
      "location": "assets/images/items/horse-purple.png",
      "description": "They say purple is the colour of royalty. Who knows, "
          "maybe this horse once belonged to a distant monarch?",
    },
    "cart_flat": {
      "key": "cart_flat",
      "name": "Cart level 1",
      "type": cartKey,
      "cost": 10,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Flat.png",
      "locationAnimated": "assets/images/items/CartFlat.png",
      "description": "Guess this counts as a cart...",
    },
    "cart_sticks": {
      "key": "cart_sticks",
      "name": "Stick Cart",
      "type": cartKey,
      "cost": 50,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Sticks.png",
      "locationAnimated": "assets/images/items/CartSticks.png",
      "description": "A real farmer's cart.",
    },
    "cart_sticks_pine": {
      "key": "cart_sticks_pine",
      "name": "Pine Stick Cart",
      "type": cartKey,
      "cost": 100,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Sticks_Pine.png",
      "locationAnimated": "assets/images/items/CartSticksPine.png",
      "description": "You work with what you have and in this case, that was "
          "pine.",
    },
    "cart_plank": {
      "key": "cart_plank",
      "name": "Plank Cart",
      "type": cartKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Planks.png",
      "locationAnimated": "assets/images/items/CartPlanks.png",
      "description": "Something sturdy to carry all the essentials.",
    },
    "cart_planks_pine": {
      "key": "cart_planks_pine",
      "name": "Pine Plank Cart",
      "type": cartKey,
      "cost": 400,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Planks_Pine.png",
      "locationAnimated": "assets/images/items/CartPlanksPine.png",
      "description": "A wood blend works when you know your woods...which I "
          "don't.",
    },
    "cart-tarp": {
      "key": "cart-tarp",
      "name": "Tarp Cart",
      "type": cartKey,
      "cost": 600,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Tarp.png",
      "locationAnimated": "assets/images/items/CartTarp.png",
      "description": "Something to keep the rain off in your travels.",
    },
    "cart-purple": {
      "key": "cart-purple",
      "name": "Purple cart",
      "type": cartKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Tarp_Purple.png",
      "locationAnimated": "assets/images/items/CartTarpPurple.png",
      "description": "Something purple to add to your 'royal' entourage.",
    },
    "cart-blue": {
      "key": "cart-blue",
      "name": "Blue cart",
      "type": cartKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/Cart_Tarp_Blue.png",
      "locationAnimated": "assets/images/items/CartTarpNavy.png",
      "description": "A beautiful dash of blue to blend in with the sky.",
    },
    "cart-red": {
      "key": "cart-red",
      "name": "Red cart",
      "type": cartKey,
      "cost": 400,
      "purchaseCurrency": gems,
      "location": "assets/images/items/Cart_Tarp_Red.png",
      "locationAnimated": "assets/images/items/CartTarpRed.png",
      "description": "Prepared to go fast? I'm sure painting things red isn't"
          " just an urban myth...",
    },
    "cart-aqua": {
      "key": "cart-aqua",
      "name": "Aqua cart",
      "type": cartKey,
      "cost": 400,
      "purchaseCurrency": gems,
      "location": "assets/images/items/Cart_Tarp_Aqua.png",
      "locationAnimated": "assets/images/items/CartTarpAqua.png",
      "description": "Stand out in the crowd with something brighter!",
    },
    "cat-white": {
      "key": "cat-white",
      "name": "White Cat",
      "type": petKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cat-white.png",
      "description": "A brand new pet for your caravan!",
    },
    "cat-black": {
      "key": "cat-black",
      "name": "Black Cat",
      "type": petKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cat-black.png",
      "description": "A brand new pet for your caravan!",
    },
    "cat-orange": {
      "key": "cat-orange",
      "name": "Tabby Cat",
      "type": petKey,
      "cost": 400,
      "purchaseCurrency": coins,
      "location": "assets/images/items/cat-orange.png",
      "description": "A brand new pet for your caravan!",
    },
    "dog-brown": {
      "key": "dog-brown",
      "name": "Brown Dog",
      "type": petKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/dog-brown.png",
      "description": "A brand new pet for your caravan!",
    },
    "dog-yellow": {
      "key": "dog-yellow",
      "name": "Yellow Dog",
      "type": petKey,
      "cost": 400,
      "purchaseCurrency": coins,
      "location": "assets/images/items/dog-yellow.png",
      "description": "A brand new pet for your caravan!",
    },
    "dog-white": {
      "key": "dog-white",
      "name": "White Dog",
      "type": petKey,
      "cost": 200,
      "purchaseCurrency": coins,
      "location": "assets/images/items/dog-white.png",
      "description": "A brand new pet for your caravan!",
    },
    "bird-pink": {
      "key": "bird-pink",
      "name": "Pink Cockatoo",
      "type": petKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/bird-pink.png",
      "description": "A brand new pet for your caravan!",
    },
    "bird-blue": {
      "key": "bird-blue",
      "name": "Blue Macaw",
      "type": petKey,
      "cost": 1000,
      "purchaseCurrency": coins,
      "location": "assets/images/items/bird-blue.png",
      "description": "A brand new pet for your caravan!",
    },
    "dragon": {
      "key": "dragon",
      "name": "Purple Dragon",
      "type": petKey,
      "cost": 500,
      "purchaseCurrency": gems,
      "location": "assets/images/items/dragon.png",
      "description": "A dragon!!!",
    }
  };
}
