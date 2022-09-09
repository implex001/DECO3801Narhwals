import 'dart:ffi';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:flame/game.dart';
import 'package:caravaneering/views/overlays/caravan_bar_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SkillsView extends StatefulWidget {
  const SkillsView({super.key});

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> {
  Map selectedSkill = {
    "icon": "assets/images/skills/UpgradeSpeed.png",
    "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
    "introduction": "introduction, introduction",
    "buyState": false,
    "index": 0,
  };

  List<Map> skillList = [
    {
      "icon": "assets/images/skills/UpgradeSpeed.png",
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 0,
    },
    {
      "icon": "assets/images/skills/Upgrade_Strength.png",
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 1,
    },
    {
      "icon": "assets/images/skills/UpgradeCoins.png",
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 2,
    },
    {
      "icon": "assets/images/skills/UpgradeSpeed.png",
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 3,
    },
    {
      "icon": "assets/images/skills/Upgrade_Strength.png",
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 4,
    },
    {
      "icon": "assets/images/skills/UpgradeCoins.png",
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 5,
    },
    {
      "icon": "assets/images/skills/UpgradeSpeed.png",
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 6,
    },
    {
      "icon": "assets/images/skills/Upgrade_Strength.png",
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 7,
    },
    {
      "icon": "assets/images/skills/UpgradeCoins.png",
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 8,
    },
    {
      "icon": "assets/images/skills/UpgradeSpeed.png",
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 9,
    },
    {
      "icon": "assets/images/skills/Upgrade_Strength.png",
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 10,
    },
    {
      "icon": "assets/images/skills/UpgradeCoins.png",
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 11,
    },
    {
      "icon": "assets/images/skills/UpgradeSpeed.png",
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 12,
    },
    {
      "icon": "assets/images/skills/Upgrade_Strength.png",
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 13,
    },
    {
      "icon": "assets/images/skills/UpgradeCoins.png",
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 14,
    },
    {
      "icon": "assets/images/skills/UpgradeSpeed.png",
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 15,
    },
    {
      "icon": "assets/images/skills/Upgrade_Strength.png",
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 16,
    },
    {
      "icon": "assets/images/skills/UpgradeCoins.png",
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "buyState": false,
      "index": 17,
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool selectedSkillBuyState = selectedSkill["buyState"];
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("aaaaaaaaaa"),
      ),
      body: Container(
        height: height,
        width: width,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/skills/SkillsBackground.png",
                      height: height,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      "assets/images/skills/Skills-Lines.png",
                      height: height,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                    // ***** 调节点 *****
                    SingleChildScrollView(
                        child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // 每行三列
                        childAspectRatio: 1.5, // 显示区域宽高相等
                        // 上下左右的内边距
                        mainAxisSpacing: 5.0,
                        // 主轴元素间距
                        crossAxisSpacing: 5.0,
                      ),
                      itemCount: skillList.length,
                      itemBuilder: (context, index) {
                        bool buyState = skillList[index]["buyState"];
                        return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              setState(() {
                                selectedSkill = skillList[index];
                              });
                            },
                            child: Image.asset(buyState
                                ? skillList[index]["icon"]
                                : skillList[index]["iconLocked"]));
                      },
                    )),
                  ],
                )),
            Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image:
                          AssetImage("assets/images/skills/Skills-Popup.png"),
                      fit: BoxFit.fitWidth,
                    )),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 24,
                          ),
                          Image.asset(
                            selectedSkillBuyState
                                ? selectedSkill["icon"]
                                : selectedSkill["iconLocked"],
                            width: 64,
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              selectedSkill["introduction"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          if (!selectedSkillBuyState)
                            (TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedSkill["buyState"] = true;
                                    skillList[selectedSkill["index"]]
                                        ["buyState"] = true;
                                  });
                                },
                                child: Image.asset(
                                    "assets/images/UI/BuyButton.png",
                                    height: 20)))
                        ])))
          ],
        ),
      ),
      // This trailing comma makeormatting nicer for build methods.
    );
  }
}
