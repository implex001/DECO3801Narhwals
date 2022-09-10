import 'dart:math';

import 'package:caravaneering/model/save_model.dart';

class Skill {
  SaveModel save;
  Skill(this.save);
  List<Map> skillList = [];
  static const treeHeight = 12;

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
      if (personal > i) {
        pState = true;
      }
      int cost = pow(50, (i+1/2)).round();
      skillList.add(
          {
            "icon": "assets/images/skills/Upgrade_Strength.png",
            "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
            "introduction": "Personal Upgrade, Upgrade your personal caravan to"
                " increase the points you get from idle activites. Costs:$cost",
            "buyState": pState,
            "index": i * 2,
            "cost": cost,
          });
      gState = false;
      if (group > i) {
        gState = true;
      }
      skillList.add(
          {
            "icon": "assets/images/skills/UpgradeCoins.png",
            "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
            "introduction": "Group Upgrade, Bring more people to your caravan to"
                " increase the points you earn from minigames. Costs:$cost",
            "buyState": gState,
            "index": i * 2 + 1,
            "cost": cost,
          });
    }
  }

  void addSkill(int index) {
    skillList[index]["buyState"] = true;
    if (index % 2 != 0) {
      save.groupSkillUp();
    } else {
      save.personalSkillUp();
    }
  }

  bool purchase(int cost) {
    if (cost <= save.get("coins")) {
      save.removeCoins(cost);
      return true;
    } else {
      return false;
    }
  }
}