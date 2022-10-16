import 'dart:async';

import 'package:caravaneering/model/save.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/shop/shop_items.dart';
import 'package:caravaneering/model/story.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/play_sound.dart';

class SaveModel extends ChangeNotifier {
  final SaveState save = SaveState();
  bool hasChanged = false;
  bool hasErasedData = false;
  bool hasUpdatedEquipped = false;
  bool hasUpdatedBiome = false;
  Timer? autoSave;

  Future<SaveModel> init() async {
    if (await save.checkForLocalSave()) {
      await save.loadFromLocal();
    } else {
      await save.createLocalSave();
    }
    notifyListeners();
    return this;
  }

  dynamic get(String key) {
    return save.state[key];
  }

  void addSteps(int number) {
    changeMisc(
        SaveKeysV1.lifeTimeSteps, get(SaveKeysV1.lifeTimeSteps) + number);
  }

  void addCoins(int number) {
    PlaySoundUtil.instance().play("audio/coins_1sec_consistent.mp3");
    changeMisc(SaveKeysV1.coins, get(SaveKeysV1.coins) + number);
  }

  void removeCoins(int number) {
    changeMisc(SaveKeysV1.coins, get(SaveKeysV1.coins) - number);
  }

  void addGems(int number) {
    PlaySoundUtil.instance().play("audio/coins_1sec_consistent.mp3");
    changeMisc(SaveKeysV1.gems, get(SaveKeysV1.gems) + number);
  }

  void removeGems(int number) {
    changeMisc(SaveKeysV1.gems, get(SaveKeysV1.gems) - number);
  }

  void addUnlockedEpisode(String episode) {
    save.state[SaveKeysV1.unlockedEpisodes].add(episode);
  }

  // Equips a horse skin to a horse number
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

  // Equips a cart skin to a horse number
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

  // Equips a pet
  void equipPet(int petNum, String key) {
    if (save.state[SaveKeysV1.equippedPets] == null) {
      save.state[SaveKeysV1.equippedPets] = <String>[];
    }

    save.state[SaveKeysV1.equippedPets].add(key);

    hasUpdatedEquipped = true;
    notifyListeners();
  }

  void addItem(Map<String, dynamic> item) {
    if (save.state[item["type"]] == null) {
      save.state[item["type"]] = <String>[];
    }
    save.state[item["type"]].add(item["key"]);
    hasChanged = true;
    notifyListeners();
  }

  void changeBiome(BiomeType biome) {
    save.state[SaveKeysV1.currentBiome] = biome.name;
    hasUpdatedBiome = true;
    notifyListeners();
  }

  bool checkIfItemOwned(Map<String, dynamic> item) {
    if (save.state[item["type"]] == null) {
      return false;
    }
    return save.state[item["type"]].contains(item["key"]);
  }

  List<Map<String, dynamic>> getOwnedItems(String type) {
    return ShopItems
        .shopItemsDefaults[type]!
        .where((element) => checkIfItemOwned(element))
        .toList();
  }

  Timer? startAutoSave() {
    autoSave ??=
        Timer.periodic(const Duration(seconds: 10), (timer) => saveState());
    return autoSave;
  }

  void forceRefresh(){
    notifyListeners();
  }

  void saveState({force = false}) async {
    if (hasChanged || force) {
      save.state[SaveKeysV1.savedate] = DateTime.now().toIso8601String();
      await save.save();
      hasChanged = false;
    }
  }

  DateTime? getLastTime() {
    try {
      return DateTime.parse(save.state[SaveKeysV1.savedate]);
    } catch (e) {
      return null;
    }
  }

  void changeMisc(String key, dynamic value) {
    save.state[key] = value;
    hasChanged = true;
    notifyListeners();
  }

  Future<void> eraseSave() async {
    save.resetData();
    await save.save();
    hasErasedData = true;
    hasUpdatedEquipped = true;
    notifyListeners();
  }

  Future<void> personalSkillUp() async {
    changeMisc(
        SaveKeysV1.personalUpgrades, get(SaveKeysV1.personalUpgrades) + 1);
    hasUpdatedEquipped = true;
    await save.save();
  }

  Future<void> groupSkillUp() async {
    changeMisc(SaveKeysV1.groupUpgrades, get(SaveKeysV1.groupUpgrades) + 1);
    hasUpdatedEquipped = true;
    await save.save();
  }
}
