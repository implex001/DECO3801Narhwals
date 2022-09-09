import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

Widget navbarOverlay(BuildContext buildContext, CaravanGame game) {
  return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [NavbarLeftOverlay(), NavbarRightOverlay()],
    ),
    NavbarBottomOverlay(),
  ]);
  //]);
}

class NavbarLeftOverlay extends StatelessWidget {
  NavbarLeftOverlay({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/caravan", (route) => false); // placeholder route
          },
          child: Image.asset(
            'assets/images/UI/Menu.png',
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, "/shop");
          },
          child: Image.asset(
            'assets/images/UI/Shop.png',
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamed(
                context, "/skills");
          },
          child: Image.asset(
            'assets/images/UI/Skills.png',
            fit: BoxFit.contain,
            height: 30,
          )),
      GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, "/caravan", (route) => false);
          },
          child: Image.asset(
            'assets/images/UI/Caravan.png',
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
