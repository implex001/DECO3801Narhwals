import 'dart:ffi';

import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/views/overlays/tips_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/views/overlays/minigame_list.dart';
import 'package:caravaneering/views/overlays/main_menu.dart';
import 'package:caravaneering/views/overlays/coming_soon.dart';

/// Game engine function to build navbar overlay.
/// For Flame use only
Widget flameNavbarOverlay(BuildContext buildContext, CaravanGame game) {
  return const NavBar();
}

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Stack(
        children: [
          Image.asset(
            'assets/images/placeholders/WoodenBar.png',
            height: 30,
            fit: BoxFit.contain,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [NavbarLeftOverlay(), NavbarRightOverlay()],
          )
        ],
      ),
      NavbarBottomOverlay(),
    ]);
  }
}

class NavbarLeftOverlay extends StatefulWidget {
  NavbarLeftOverlay({Key? key});

  @override
  State<NavbarLeftOverlay> createState() => _NavbarLeftOverlayState();
}

class _NavbarLeftOverlayState extends State<NavbarLeftOverlay> {
  String route = "";
  String menuButtonImage = 'assets/images/UI/Menu.png';
  String shopButtonImage = 'assets/images/UI/Shop.png';
  String skillsButtonImage = 'assets/images/UI/Skills.png';
  String caravanButtonImage = 'assets/images/UI/Caravan.png';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.name != null) {
      route = ModalRoute.of(context)!.settings.name!;
      switch (route) {
        case "/menu":
          menuButtonImage = 'assets/images/UI/MenuSelected.png';
          break;
        case "/shop":
          shopButtonImage = 'assets/images/UI/ShopSelected.png';
          break;
        case "/skills":
          skillsButtonImage = 'assets/images/UI/SkillsSelected.png';
          break;
        case "/caravan":
          caravanButtonImage = 'assets/images/UI/CaravanSelected.png';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      GestureDetector(
          onTap: () {
            MainMenuPage.showPage(context);
          },
          child: Image.asset(
            menuButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            if (route != "/shop") {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/shop", (route) => false);
            }
          },
          child: Image.asset(
            shopButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/skills");
          },
          child: Image.asset(
            skillsButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            if (route != "/caravan") {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/caravan", (route) => false);
            }
          },
          child: Image.asset(
            caravanButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
    ]);
  }
}

class NavbarRightOverlay extends StatelessWidget {
  NavbarRightOverlay({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            TipPopUp.showTips(
                context, "Coins", "This is some tips for the coins");
          },
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Image.asset(
              'assets/images/UI/Coins.png',
              height: 30,
              fit: BoxFit.contain,
            ),
            Consumer<SaveModel>(builder: (context, save, build) {
              return DefaultTextStyle(
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
                child: Text(
                  '${save.get(SaveKeysV1.coins)}',
                  textAlign: TextAlign.center,
                ),
              );
            })
          ]),
        ),
        GestureDetector(
          onTap: () {
            TipPopUp.showTips(
                context, "Gems", "This is some tips for the gems");
          },
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Image.asset(
              'assets/images/UI/Gems.png',
              height: 30,
              fit: BoxFit.contain,
            ),
            Consumer<SaveModel>(builder: (context, save, build) {
              return DefaultTextStyle(
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
                child: Text(
                  '${save.get(SaveKeysV1.gems)}',
                  textAlign: TextAlign.center,
                ),
              );
            })
          ]),
        )
      ],
    );
  }
}

class NavbarBottomOverlay extends StatefulWidget {
  NavbarBottomOverlay({Key? key});

  @override
  State<NavbarBottomOverlay> createState() => _NavbarBottomOverlayState();
}

class _NavbarBottomOverlayState extends State<NavbarBottomOverlay> {
  String route = "";
  String mingameButtonImage = 'assets/images/UI/Minigames.png';
  bool isCaravanPage = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.name != null) {
      route = ModalRoute.of(context)!.settings.name!;
      switch (route) {
        case "/caravan":
          isCaravanPage = true;
          break;
        case "/cave-intro":
          mingameButtonImage = 'assets/images/UI/MinigamesSelected.png';
          isCaravanPage = false;
          break;
        case "/minigames/jump":
          mingameButtonImage = 'assets/images/UI/MinigamesSelected.png';
          isCaravanPage = false;
          break;
        default:
          isCaravanPage = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isCaravanPage) {
      return Container();
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              MinigameSelectorPage.showPage(context);
            },
            child: Image.asset(
              mingameButtonImage,
              fit: BoxFit.contain,
              height: 30,
            )),
        GestureDetector(
            onTap: () {
              ComingSoonPage.showPage(context, "Story page coming soon!");
            },
            child: Image.asset(
              'assets/images/UI/Story.png',
              fit: BoxFit.contain,
              height: 30,
            )),
      ]);
    }
  }
}
