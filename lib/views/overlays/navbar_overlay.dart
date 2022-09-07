import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      Image.asset(
        'assets/images/UI/Menu.png',
        fit: BoxFit.contain,
        height: 30,
        //width: MediaQuery.of(context).size.width * 0.14,
      ),
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/shop'),
        child: Image.asset(
          'assets/images/UI/Shop.png',
          //width: MediaQuery.of(context).size.width * 0.14,
          height: 30,
          fit: BoxFit.contain,
        ),
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
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              'assets/images/UI/Coins.png',
              height: 30,
              fit: BoxFit.contain,
            ),
            Consumer<SaveModel>(builder: (context, save, child) {
              return DefaultTextStyle(
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
                child: Text(
                  '${save.get(SaveKeysV1.coins)}',
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ],
        ),
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
        onTap: () => Navigator.pushNamed(context, "/minigames"),
        child: Image.asset(
          'assets/images/UI/Minigames.png',
          fit: BoxFit.contain,
          height: 30,
          //width: MediaQuery.of(context).size.width * 0.14,
        ),
      ),
      Image.asset(
        'assets/images/UI/Story.png',
        fit: BoxFit.contain,
        height: 30,
        //width: MediaQuery.of(context).size.width * 0.14,
      ),
    ]);
  }
}
