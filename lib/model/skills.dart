import 'dart:math';

import 'package:caravaneering/model/save_model.dart';

/// Skills definitions
class Skill {
  SaveModel save;

  Skill(this.save);

  List<Map<String, dynamic>> skillList = [];
  static const treeHeight = 12;

  static const Map<int, String> groupUpgradeImage = {
    1: "BaseNPC2",
    2: "BaseNPC1",
    3: "Donkey",
  };

  void setupTree() {
    int personal = save.get("personalUpgrades");
    int group = save.get("groupUpgrades");
    bool pState;
    bool gState;
    if (personal > treeHeight) {
      personal = treeHeight;
    }
    if (group > treeHeight) {
      group = treeHeight;
    }
    for (var i = 0; i < treeHeight; i++) {
      pState = false;
      if (personal > i + 1) {
        pState = true;
      }
      int cost = pow(10, (i + 1)).round();
      skillList.add({
        "icon": "assets/images/skills/Skill-Personal.png",
        "iconLocked": "assets/images/skills/Skill-Personal-Locked.png",
        "introduction": "Personal Upgrade, Upgrade your personal caravan to"
            " increase the points you get from idle activites. Costs:$cost",
        "buyState": pState,
        "index": i * 2,
        "cost": cost,
        "location": "assets/images/skills/Skill-Personal.png"
      });
      gState = false;
      if (group > i + 1) {
        gState = true;
      }
      skillList.add({
        "icon": "assets/images/skills/Skill-Group.png",
        "iconLocked": "assets/images/skills/Skill-Group-Locked.png",
        "introduction": "Group Upgrade, Bring more people to your caravan to"
            " increase the points you earn from minigames. Costs:$cost",
        "buyState": gState,
        "index": i * 2 + 1,
        "cost": cost,
        "location": "assets/images/skills/Skill-Group.png"
      });
    }
  }

  /// Adds a skill
  void addSkill(int index) {
    skillList[index]["buyState"] = true;
    if (index % 2 != 0) {
      save.groupSkillUp();
    } else {
      save.personalSkillUp();
    }
  }

  /// Deducts coin balance if possible
  bool purchase(int cost) {
    if (cost <= save.get("coins")) {
      save.removeCoins(cost);
      return true;
    } else {
      return false;
    }
  }
}
