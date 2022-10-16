import 'dart:async';

import 'package:caravaneering/model/save.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/shop/shop_items.dart';
import 'package:caravaneering/model/story.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/model/play_sound.dart';

/// State definition and manipulation of user save
class SaveModel extends ChangeNotifier {
  final SaveState save = SaveState();
  bool hasChanged = false;
  bool hasErasedData = false;
  bool hasUpdatedEquipped = false;
  bool hasUpdatedBiome = false;
  Timer? autoSave;

  /// Initialises save from storage or creates a new one
  Future<SaveModel> init() async {
    if (await save.checkForLocalSave()) {
      await save.loadFromLocal();
    } else {
      await save.createLocalSave();
    }
    notifyListeners();
    return this;
  }

  /// Gets the variable from the save from given [key]
  dynamic get(String key) {
    return save.state[key];
  }

  /// Increments steps by [number]
  void addSteps(int number) {
    changeMisc(
        SaveKeysV1.lifeTimeSteps, get(SaveKeysV1.lifeTimeSteps) + number);
  }

  /// Increments coins by [number]
  void addCoins(int number) {
    changeMisc(SaveKeysV1.coins, get(SaveKeysV1.coins) + number);
  }

  /// Removes coins by [number]
  void removeCoins(int number) {
    changeMisc(SaveKeysV1.coins, get(SaveKeysV1.coins) - number);
  }

  /// Increments gems by [number]
  void addGems(int number) {
    PlaySoundUtil.instance().play("audio/coins_1sec_consistent.mp3");
    changeMisc(SaveKeysV1.gems, get(SaveKeysV1.gems) + number);
  }

  /// Removes gems by [number]
  void removeGems(int number) {
    changeMisc(SaveKeysV1.gems, get(SaveKeysV1.gems) - number);
  }

  /// Adds episode name to [SaveKeysV1.episodes]
  void addUnlockedEpisode(String episode) {
    save.state[SaveKeysV1.unlockedEpisodes].add(episode);
  }

  /// Equips a horse skin to a horse number
  void equipHorse(int horseNum, String key) {
    if (save.state[SaveKeysV1.equippedHorses] == null) {
      save.state[SaveKeysV1.equippedHorses] = <String>[];
    }

    // If the index number hasn't been created in the list then add blank names
    while (save.state[SaveKeysV1.equippedHorses].length < horseNum) {
      save.state[SaveKeysV1.equippedHorses].add("");
    }
    save.state[SaveKeysV1.equippedHorses][horseNum - 1] = key;

    hasUpdatedEquipped = true;
    notifyListeners();
  }

  /// Equips a cart skin to a horse number
  void equipCart(int cartNum, String key) {
    if (save.state[SaveKeysV1.equippedCarts] == null) {
      save.state[SaveKeysV1.equippedCarts] = <String>[];
    }

    // If the index number hasn't been created in the list then add blank names
    while (save.state[SaveKeysV1.equippedCarts].length < cartNum) {
      save.state[SaveKeysV1.equippedCarts].add("");
    }
    save.state[SaveKeysV1.equippedCarts][cartNum - 1] = key;

    hasUpdatedEquipped = true;
    notifyListeners();
  }

  /// Equips a pet
  void equipPet(int petNum, String key) {
    if (save.state[SaveKeysV1.equippedPets] == null) {
      save.state[SaveKeysV1.equippedPets] = <String>[];
    }

    save.state[SaveKeysV1.equippedPets].add(key);

    hasUpdatedEquipped = true;
    notifyListeners();
  }

  /// Adds an item to purchased items
  void addItem(Map<String, dynamic> item) {
    if (save.state[item["type"]] == null) {
      save.state[item["type"]] = <String>[];
    }
    save.state[item["type"]].add(item["key"]);
    hasChanged = true;
    notifyListeners();
  }

  /// Change biome to [biome]
  void changeBiome(BiomeType biome) {
    save.state[SaveKeysV1.currentBiome] = biome.name;
    hasUpdatedBiome = true;
    notifyListeners();
  }

  /// Check if an item is owned
  bool checkIfItemOwned(Map<String, dynamic> item) {
    if (save.state[item["type"]] == null) {
      return false;
    }
    return save.state[item["type"]].contains(item["key"]);
  }

  /// Gets all of the owned items
  List<Map<String, dynamic>> getOwnedItems(String type) {
    return ShopItems.shopItemsDefaults[type]!
        .where((element) => checkIfItemOwned(element))
        .toList();
  }

  /// Starts autosave with a period of 10 seconds
  Timer? startAutoSave() {
    autoSave ??=
        Timer.periodic(const Duration(seconds: 10), (timer) => saveState());
    return autoSave;
  }

  /// Force refreshes all listeners
  void forceRefresh() {
    notifyListeners();
  }

  /// Save the state to local storage
  void saveState({force = false}) async {
    if (hasChanged || force) {
      save.state[SaveKeysV1.savedate] = DateTime.now().toIso8601String();
      await save.save();
      hasChanged = false;
    }
  }

  /// Get the last save time
  DateTime? getLastTime() {
    try {
      return DateTime.parse(save.state[SaveKeysV1.savedate]);
    } catch (e) {
      return null;
    }
  }

  /// Change a value
  void changeMisc(String key, dynamic value) {
    save.state[key] = value;
    hasChanged = true;
    notifyListeners();
  }

  /// Erase the save
  Future<void> eraseSave() async {
    save.resetData();
    await save.save();
    hasErasedData = true;
    hasUpdatedEquipped = true;
    notifyListeners();
  }

  /// Upgrades the personal skill
  Future<void> personalSkillUp() async {
    changeMisc(
        SaveKeysV1.personalUpgrades, get(SaveKeysV1.personalUpgrades) + 1);
    hasUpdatedEquipped = true;
    await save.save();
  }

  /// Upgrades the group skill
  Future<void> groupSkillUp() async {
    changeMisc(SaveKeysV1.groupUpgrades, get(SaveKeysV1.groupUpgrades) + 1);
    hasUpdatedEquipped = true;
    await save.save();
  }
}
