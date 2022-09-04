import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/games/jump_minigame.dart';
import 'package:caravaneering/model/jump_tracker.dart';
import 'package:flutter/material.dart';


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
  int jumpCount = 0;
  JumpMiniGame jumpMiniGame = JumpMiniGame(const Duration(seconds: 60));

  @override
  void initState() {
    super.initState();
    jumpMiniGame.start();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Text("Jump: $jumpCount"),
    );
  }
}

