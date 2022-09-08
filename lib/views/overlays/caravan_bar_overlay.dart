import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget caravanBarOverlay(BuildContext buildContext, CaravanGame game) {
  return CaravanBarOverlay(game: game);
}

class CaravanBarOverlay extends StatelessWidget {
  final CaravanGame game;

  CaravanBarOverlay({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.amber,
          child: Row(children: [
            TextButton(onPressed: () {}, child: Text("Menu")),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/shop');
                },
                child: Text("Shop")),
            TextButton(onPressed: () {}, child: Text("Skills")),
            TextButton(onPressed: () {}, child: Text("Caravan")),
            const Spacer(),
            Consumer<SaveModel>(builder: (context, save, child) {
              return Text('${save.get(SaveKeysV1.coins)}',
                  style: Theme.of(context).textTheme.headline5);
            })
          ]),
        ),
        const Spacer(),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  game.navigateMiniGameOverlay();
                },
                child: const Text("Minigames",
                    style: TextStyle(
                      color: Colors.black,
                    ))),
            const Spacer(),
            TextButton(
                onPressed: () {},
                child: const Text("Story",
                    style: TextStyle(
                      color: Colors.black,
                    ))),
          ],
        ),
      ],
    );
  }
}
