
class ShopItems{

  // A key name for each shop type used to access different dictionaries. This
  // text should not be displayed anywhere on the app
  static const horseKey = "horse";
  static const diffKey = "diff";
  static const defaultKey = horseKey;

  // The current items in the shop for each shop type
  static const Map<String, List<String>> shopItemsDefaults = {
    horseKey: [
      "horse-yellow.png", "horse-dark-grey.png", "horse-light-grey.png",
      "horse-blue.png", "horse-dark-blue.png", "horse-light-green.png",
      "horse-dark-green.png", "horse-pink.png", "horse-purple.png",
    ],
    diffKey: [
      "horse-blue.png", "horse-dark-blue.png", "horse-light-green.png",
      "horse-dark-green.png", "horse-pink.png", "horse-purple.png",
      "horse-yellow.png", "horse-dark-grey.png", "horse-light-grey.png",
    ],
  };

  // The sold out image relating to each shop type
  static const Map<String, String> shopSoldOutVisual = {
    horseKey: "horse-sold-out.png",
    diffKey: "horse-sold-out.png",
  };
}