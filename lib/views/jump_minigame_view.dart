import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/games/jump_minigame.dart';
import 'package:caravaneering/model/jump_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget jumpMiniGame(BuildContext buildContext, CaravanGame game) {
  return JumpMiniGameView();
}

class JumpMiniGameView extends StatefulWidget {
  const JumpMiniGameView({Key? key}) : super(key: key);

  @override
  State<JumpMiniGameView> createState() => _JumpMiniGameState();
}

class _JumpMiniGameState extends State<JumpMiniGameView> {

  JumpTracker tracker = JumpTracker();
  int scoreCount = 0;
  JumpMiniGame jumpMiniGame = JumpMiniGame(const Duration(seconds: 60));

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);

    jumpMiniGame.start();
    jumpMiniGame.score.addListener(() {
      setState(() {
        scoreCount = jumpMiniGame.score.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        children: [
          TextButton(onPressed: () {
            SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft]);
            Navigator.pushNamedAndRemoveUntil(
                context, "/caravan", (route) => false
            );
            },
              child: const Text("Exit")),
          Text("Score: $scoreCount"),
        ],
      ),
    );
  }
}

