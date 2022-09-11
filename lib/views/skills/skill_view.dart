import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/skills.dart';
import 'package:provider/provider.dart';

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
  Skill? skill;

  @override
  Widget build(BuildContext context) {
    bool selectedSkillBuyState = selectedSkill["buyState"];
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;


    if (skill == null) {
      skill = Skill(Provider.of<SaveModel>(context, listen: true));
      skill!.setupTree();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
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
                            crossAxisCount: 2, // 每行三列
                            childAspectRatio: 2.5, // 显示区域宽高相等
                            // 上下左右的内边距
                            mainAxisSpacing: 5.0,
                            // 主轴元素间距
                            crossAxisSpacing: 5.0,
                          ),
                          itemCount: skill!.skillList.length,
                          itemBuilder: (context, index) {
                            bool buyState = skill!.skillList[index]["buyState"];
                            return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() {
                                    selectedSkill = skill!.skillList[index];
                                  });
                                },
                                child: Image.asset(buyState
                                    ? skill!.skillList[index]["icon"]
                                    : skill!.skillList[index]["iconLocked"]));
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
                                  if(skill!.purchase(selectedSkill["cost"]))
                                    setState(() {
                                      selectedSkill["buyState"] = true;
                                      skill!.addSkill(selectedSkill["index"]);
                                    });
                                },
                                child: Image.asset(
                                    "assets/images/UI/BuyButton.png",
                                    height: 20)))
                        ]))),
          ],
        ),
      ),
      // This trailing comma makeormatting nicer for build methods.
    );
  }
}
