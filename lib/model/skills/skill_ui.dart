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
    "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
    "introduction": "introduction, introduction",
    "index": 0,
  };

  List<Map> skillList = [
    {
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "index": 0,
    },
    {
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "index": 1, 
    },
    {
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "index": 2,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "index": 3,
    },
    {
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "index": 4,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "index": 5,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "index": 6,
    },
    {
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "index": 7,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "index": 8,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "index": 9,
    },
    {
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "index": 10,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "index": 11,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "index": 12,
    },
    {
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "index": 13,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "index": 14,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeSpeedLocked.png",
      "introduction": "introduction, introduction",
      "index": 15,
    },
    {
      "iconLocked": "assets/images/skills/Upgrade_StrengthLocked.png",
      "introduction": "introduction, introduction",
      "index": 16,
    },
    {
      "iconLocked": "assets/images/skills/UpgradeCoinsLocked.png",
      "introduction": "introduction, introduction",
      "index": 17,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("aaaaaaaaaa"),
      ),
      body: Container(
        height: height,
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
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                      "assets/images/skills/Skills-Lines.png",
                      height: height,
                      fit: BoxFit.fill,
                    ),
                    // ***** 调节点 *****
                    Padding(padding: EdgeInsets.only(left: 40,right: 40,top: 40,bottom: 20),child: Transform.translate(
                      offset: Offset(-5, 0),
                      child: SingleChildScrollView(
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
                              return GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    setState(() {
                                      selectedSkill = skillList[index];
                                    });
                                  },
                                  child: Image.asset(skillList[index]["iconLocked"]));
                            },
                          )),
                    ),)
                  ],
                )),
            Expanded(
                child: Stack(
                  children: [
                    Image.asset("assets/images/skills/Skills-Popup.png",height: height,fit: BoxFit.fill),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 24,),
                        Image.asset(selectedSkill["iconLocked"],width: 64,),
                        SizedBox(height: 24,),
                        Padding(padding: EdgeInsets.only(left: 5,right: 5),
                          child: Text(
                            selectedSkill["introduction"],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                          ),),
                        SizedBox(height: 24,),
                            TextButton(onPressed: () {
                              setState(() {
                                selectedSkill["buyState"] = true;
                                skillList[selectedSkill["index"]]["buyState"] = true;
                              });
                            }, child: Image.asset("assets/images/UI/BuyButton.png", height: 20)
                        )
                        ]
                    )
                  ],
                ))
          ],
        ),
      ),
    );
    
  } 
}