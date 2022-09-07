import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

Widget miniGameOverlay(BuildContext buildContext, CaravanGame game) {
  return MiniGameList(game: game);
}

class MiniGameList extends StatelessWidget {

  final CaravanGame game;

  const MiniGameList({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child:
        ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/minigames/jump");
                },
                child: Text("Minigame 1")
            ),
            TextButton(onPressed: (){}, child: Text("Placeholder")),
            TextButton(onPressed: (){}, child: Text("Placeholder")),
            TextButton(
                onPressed: (){
                  game.exitMiniGameOverlay();
                },
                child: Text("Back")
            ),
          ],
        ),
    );
  }
}
