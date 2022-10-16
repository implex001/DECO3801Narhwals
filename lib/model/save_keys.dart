/// Keys for storing save data
///
/// Versioning is used to keep track of key changes and migrate
/// devices between saving schemes if need be
class SaveKeysV1 {
  static const saveKeyVersion = 1;

  static const version = "version";
  static const username = "username";
  static const coins = "coins";
  static const gems = "gems";
  static const personalUpgrades = "personalUpgrades";
  static const groupUpgrades = "groupUpgrades";
  static const savedate = "savedate";
  static const horses = "horses";
  static const carts = "cart";
  static const pets = "pets";
  static const equippedHorses = "equippedHorses";
  static const equippedCarts = "equippedCarts";
  static const equippedPets = "equippedPets";
  static const unlockedEpisodes = "unlockedEpisodes";
  static const lifeTimeSteps = "lifeTimeSteps";
  static const currentBiome = "currentBiome";
}
