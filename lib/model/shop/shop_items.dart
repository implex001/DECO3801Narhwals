
class ShopItems{

  static const horseKey = "horse";
  static const diffKey = "diff";

  static const Map<String, List<String>> shopItemsDefaults = {
    horseKey: [
      "horse-yellow.png", "horse-dark-grey.png", "horse-light-grey.png",
      "horse-blue.png", "horse-dark-blue.png", "horse-light-green.png",
      "horse-dark-green.png", "horse-pink.png", "horse-purple.png",
    ],
    diffKey: [
      "horse-blue.png", "horse-dark-blue.png", "horse-light-green.png",
      "horse-dark-green.png", "horse-pink.png", "horse-purple.png",
      "horse-pink.png", "horse-dark-grey.png", "horse-light-grey.png",
    ],
  };

  static const Map<String, String> shopSoldOutVisual = {
    horseKey: "horse-sold-out.png",
    diffKey: "horse-sold-out.png",
  };
}