import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:caravaneering/views/overlays/navbar_overlay.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/skills.dart';
import 'package:provider/provider.dart';
import 'flicker.dart';
import 'dart:math';
import 'package:caravaneering/views/shop/shop_purchase_confirmation.dart';
import 'package:caravaneering/model/play_sound.dart';

/// View for the skill shop
class SkillsView extends StatefulWidget {
  const SkillsView({super.key});

  @override
  State<SkillsView> createState() => _SkillsViewState();
}

class _SkillsViewState extends State<SkillsView> {
  Map<String, dynamic> selectedSkill = {
    "icon": "assets/images/skills/Skill-Personal.png",
    "iconLocked": "assets/images/skills/Skill-Personal-Locked.png",
    "introduction": "introduction",
    "buyState": false,
    "index": 0,
  };
  Skill? skill;

  // Whether the item description is currently shown
  bool showItemDescription = false;

  // Pop up window to confirm the purchase
  Future<void> confirmPurchase() async {
    if (skill == null) {
      return;
    }

    bool enoughCurrency = skill!.save.get('coins') >= selectedSkill["cost"];
    for (int i = 0; i < skill!.skillList.length; i++) {
      int selectedIndex = selectedSkill["index"];
      bool isLeft = selectedIndex % 2 == 0;
      if (isLeft) {
        if (i < selectedSkill["index"] && (i % 2 == 0)) {
          if (skill!.skillList[i]["buyState"] == false) {
            enoughCurrency = false;
            break;
          }
        }
      } else {
        if (i < selectedSkill["index"] && (i % 2 != 0)) {
          if (skill!.skillList[i]["buyState"] == false) {
            enoughCurrency = false;
            break;
          }
        }
      }
    }
    PurchaseConfirmationPage.showPage(
        context, enoughCurrency, selectedSkill, purchaseItem);
  }

  // Attempts to purchase an item
  void purchaseItem() {
    if (skill == null) {
      return;
    }

    setState(() {
      if (skill!.purchase(selectedSkill["cost"])) {
        PlaySoundUtil.instance().play("audio/purchase.mp3");
        skill!.addSkill(selectedSkill["index"]);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (skill == null) {
      skill = Skill(Provider.of<SaveModel>(context, listen: true));
      skill!.setupTree();
    }

    if (skill != null && selectedSkill["introduction"] == "introduction") {
      selectedSkill = skill!.skillList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    bool selectedSkillBuyState = selectedSkill["buyState"];
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    double safePadding = max(MediaQuery.of(context).padding.right, 15);

    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/skills/Skills Solid Line.png",
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            "assets/images/skills/Skills Dashed Line.png",
                            fit: BoxFit.fill,
                          ),
                          Image.asset(
                            "assets/images/skills/Skills Solid Line.png",
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                          child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          mainAxisSpacing: 5.0,
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
                              child: selectedSkill == skill!.skillList[index]
                                  ? FlickerAnimation(
                                      iconPath: Image.asset(buyState
                                          ? skill!.skillList[index]["icon"]
                                          : skill!.skillList[index]
                                              ["iconLocked"]),
                                      t_width: 180,
                                      t_height: 180,
                                    )
                                  : Image.asset(buyState
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
                              height: 12,
                            ),
                            Image.asset(
                              selectedSkillBuyState
                                  ? selectedSkill["icon"]
                                  : selectedSkill["iconLocked"],
                              width: 64,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: safePadding, right: safePadding),
                              child: Text(
                                selectedSkill["name"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.orange[200],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: safePadding, right: safePadding),
                              child: Text(
                                selectedSkill["introduction"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            if (!selectedSkillBuyState)
                              (TextButton(
                                  onPressed: () {
                                      PlaySoundUtil.instance().play("audio/button_click.mp3");
                                      confirmPurchase();
                                    },
                                    child: Image.asset("assets/images/UI/BuyButton.png", height: 30)
                                )
                              )
                          ]))),
            ],
          ),
        ),
      ),
      const NavBar(),
    ]);
  }
}
