import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

Widget navbarOverlay(BuildContext buildContext, CaravanGame game) {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [NavbarLeftOverlay(game: game), NavbarRightOverlay()],
    ),
    NavbarBottomOverlay(),
  ]);
  //]);
}

class NavbarLeftOverlay extends StatefulWidget {
  NavbarLeftOverlay({Key? key, required this.game});
  final CaravanGame game;

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
    if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.name != null) {
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
            Navigator.pushNamedAndRemoveUntil(
                context, "/caravan", (route) => false); // placeholder route
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
                  context, "/shop", (route) => false, arguments:{'game': widget.game}
              );
            }
          },
          child: Image.asset(
            shopButtonImage,
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/caravan", (route) => false); // placeholder route
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
        Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset(
            'assets/images/UI/Coins.png',
            height: 30,
            fit: BoxFit.contain,
          ),
          const DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
            child: Text(
              'XXXX', // Place holder for number of coins
              textAlign: TextAlign.center,
            ),
          )
        ]),
        Stack(alignment: AlignmentDirectional.center, children: [
          Image.asset(
            'assets/images/UI/Gems.png',
            height: 30,
            fit: BoxFit.contain,
          ),
          const DefaultTextStyle(
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
            child: Text(
              'XXXX', // Place holder for number of gems
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ],
    );
  }
}

class NavbarBottomOverlay extends StatelessWidget {
  NavbarBottomOverlay({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, "/minigames");
          },
          child: Image.asset(
            'assets/images/UI/Minigames.png',
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/caravan", (route) => false);
          },
          child: Image.asset(
            'assets/images/UI/Story.png',
            fit: BoxFit.contain,
            height: 30,
          )),
    ]);
  }
}
