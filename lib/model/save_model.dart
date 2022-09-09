import 'dart:async';

import 'package:caravaneering/model/save.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:flutter/material.dart';

class SaveModel extends ChangeNotifier {
  final SaveState save = SaveState();
  bool hasChanged = false;
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

  void addCoins(int number) {
    changeMisc(SaveKeysV1.coins, get(SaveKeysV1.coins) + number);
  }

  void removeCoins(int number) {
    changeMisc(SaveKeysV1.coins, get(SaveKeysV1.coins) - number);
  }

  void addHorse(String horse) {
    addToMiscList(SaveKeysV1.horses, horse);
  }

  List<String> getHorses() {
    return List<String>.from(save.state[SaveKeysV1.horses]);
  }

  bool checkIfHorseOwned(String horse) {
    return save.state[SaveKeysV1.horses].contains(horse);
  }

  Timer? startAutoSave() {
    autoSave ??= Timer.periodic(
          const Duration(seconds: 10), (timer) => saveState());
    return autoSave;
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

  void addToMiscList(String key, dynamic value) {
    save.state[key].add(value);
    hasChanged = true;
    notifyListeners();
  }

  Future<void> eraseSave() async {
    save.resetData();
    await save.save();
  }
}