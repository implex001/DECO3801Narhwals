import 'dart:async';

import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/games/jump_minigame.dart';
import 'package:caravaneering/model/jump_tracker.dart';
import 'package:caravaneering/helpers/duration_to_string.dart';
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
  String timeLeft = "0:00";
  JumpMiniGame jumpMiniGame = JumpMiniGame(const Duration(seconds: 10));

  JumpPrompt? currentPrompt = null;
  double _promptHeight = 110;
  Curve _promptCurve = Curves.bounceOut;
  Duration _promptDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    jumpMiniGame.score.addListener(() {
      setState(() {
        scoreCount = jumpMiniGame.score.value;
        _promptDuration = const Duration(milliseconds: 200);
        _promptHeight = 0;
        _promptCurve = Curves.linear;
      });
    });

    jumpMiniGame.currentTime.addListener(() {
      setState(() {
        timeLeft = minSecDurationToString(jumpMiniGame.getTimeLeft());
      });
    });

    jumpMiniGame.currentPrompt.addListener(() {
      setState(() {
        currentPrompt = jumpMiniGame.currentPrompt.value;
        _promptDuration = const Duration(milliseconds: 500);
        _promptHeight = 0;
        _promptCurve = Curves.easeOut;
      });
      Timer(const Duration(milliseconds: 500), () {
        setState(() {
          _promptHeight = MediaQuery.of(context).size.height - 400;
          _promptCurve = Curves.bounceOut;
          _promptDuration = const Duration(milliseconds: 1000);
        });
      });
    });

    jumpMiniGame.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueGrey,
      child: Stack(
        children: [
          if (currentPrompt != null)
            AnimatedPositioned(
                width: 200,
                height: 200,
                top: _promptHeight,
                left: MediaQuery.of(context).size.width / 2 - 200,
                curve: _promptCurve,
                duration: _promptDuration,
                child: Image(image: AssetImage(currentPrompt!.imagePath))),
          Column(children: [
            TextButton(
                onPressed: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.landscapeLeft]);
                  jumpMiniGame.stop();
                  jumpMiniGame.dispose();
                  Navigator.pop(context);
                },
                child: const Text("Exit")),
            Text("Time Left: $timeLeft",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ])
        ],
      ),
    );
  }
}
