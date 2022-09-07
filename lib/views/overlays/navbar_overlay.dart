import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

Widget navbarOverlay(BuildContext buildContext, CaravanGame game) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [NavbarLeftOverlay(), NavbarRightOverlay()],
  );
}

class NavbarLeftOverlay extends StatelessWidget {
  NavbarLeftOverlay({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Image.asset(
        'assets/images/UI/Menu.png',
        fit: BoxFit.contain,
        height: 30,
        //width: MediaQuery.of(context).size.width * 0.14,
      ),
      Image.asset(
        'assets/images/UI/Shop.png',
        //width: MediaQuery.of(context).size.width * 0.14,
        height: 30,
        fit: BoxFit.contain,
      ),
      Image.asset(
        'assets/images/UI/Skills.png',
        //width: MediaQuery.of(context).size.width * 0.14,
        height: 30,
        fit: BoxFit.contain,
      ),
      Image.asset(
        'assets/images/UI/Caravan.png',
        //width: MediaQuery.of(context).size.width * 0.14,
        height: 30,
        fit: BoxFit.contain,
      ),
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
