import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/views/overlays/tips_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/views/overlays/minigame_list.dart';
import 'package:caravaneering/views/overlays/main_menu.dart';
import 'package:caravaneering/model/play_sound.dart';

/// Game engine function to build navbar overlay.
/// For Flame use only
Widget flameNavbarOverlay(BuildContext buildContext, CaravanGame game) {
  return const NavBar();
}

/// Coin and Gem Display
class CoinDisplayBar extends StatelessWidget {
  const CoinDisplayBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavbarRightOverlay();
  }
}

/// Complete navigation including top and bottom bars
class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                height: 30,
                child: Image.asset(
                  'assets/images/UI/navBackground.png',
                  fit: BoxFit.fill,
                ),
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

/// Left menu buttons
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
  String backButtonImage = 'assets/images/UI/Back.png';
  bool isCaravanPage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.name != null) {
      PlaySoundUtil.instance().play("audio/button_click.mp3");
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
          isCaravanPage = true;
          caravanButtonImage = 'assets/images/UI/CaravanSelected.png';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isCaravanPage) {
      return GestureDetector(
          onTap: () {
            if (route != "/caravan") {
              Navigator.pop(context);
            }
          },
          child: Image.asset(
            backButtonImage,
            fit: BoxFit.contain,
            height: 30,
          ));
    }
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
              Navigator.pushNamed(context, "/shop");
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
                context,
                "Coins",
                "This is your basic currency. You can earn coins by taking "
                    "physical steps or through the mini-quests.");
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
                context,
                "Gems",
                "This is your special currency. "
                    "You can earn gems through special or time-gated activities.");
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

/// Bottom buttons for navigation
class NavbarBottomOverlay extends StatefulWidget {
  NavbarBottomOverlay({Key? key});

  @override
  State<NavbarBottomOverlay> createState() => _NavbarBottomOverlayState();
}

class _NavbarBottomOverlayState extends State<NavbarBottomOverlay> {
  String route = "";
  String mingameButtonImage = 'assets/images/UI/Miniquests.png';
  bool isCaravanPage = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context) != null &&
        ModalRoute.of(context)!.settings.name != null) {
      route = ModalRoute.of(context)!.settings.name!;
      PlaySoundUtil.instance().play("audio/button_click.mp3");
      switch (route) {
        case "/caravan":
          isCaravanPage = true;
          break;
        case "/cave-intro":
          mingameButtonImage = 'assets/images/UI/MiniquestsSelected.png';
          break;
        case "/minigames/jump":
          mingameButtonImage = 'assets/images/UI/MiniquestsSelected.png';
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (!isCaravanPage)
        ? Container()
        : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () {
                  PlaySoundUtil.instance().play("audio/button_click.mp3");
                  MinigameSelectorPage.showPage(context);
                },
                child: Image.asset(
                  mingameButtonImage,
                  fit: BoxFit.contain,
                  height: 30,
                )),
            GestureDetector(
                onTap: () {
                  PlaySoundUtil.instance().play("audio/button_click.mp3");
                  Navigator.pushNamed(context, "/world");
                },
                child: Image.asset(
                  'assets/images/UI/Story.png',
                  fit: BoxFit.contain,
                  height: 30,
                )),
          ]);
  }
}
