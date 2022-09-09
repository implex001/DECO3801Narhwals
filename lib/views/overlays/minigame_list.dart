import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

class MiniGameList extends StatefulWidget {

  const MiniGameList({Key? key}) : super(key: key);

  @override
  State<MiniGameList> createState() => _MiniGameListState();
}

class _MiniGameListState extends State<MiniGameList> {
  CaravanGame? game;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (game == null) {
      if (ModalRoute.of(context) != null && ModalRoute.of(context)!.settings.arguments != null) {
        Map args = ModalRoute.of(context)!.settings.arguments as Map;
        game = args["game"];
      }
    }
  }

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
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/cave-intro", (route) => false, arguments:{'game': game}
                  );
                },
                child: Text("Minigame 1")
            ),
            TextButton(onPressed: (){}, child: Text("Placeholder")),
            TextButton(onPressed: (){}, child: Text("Placeholder")),
            TextButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/caravan", (route) => false
                  );
                },
                child: Text("Back")
            ),
          ],
        ),
    );
  }
}
