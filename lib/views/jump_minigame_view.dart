import 'dart:async';

import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/games/jump_minigame.dart';
import 'package:caravaneering/model/jump_tracker.dart';
import 'package:caravaneering/helpers/duration_to_string.dart';
import 'package:caravaneering/views/game_stats_view.dart';
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

  late JumpPrompt currentPrompt;
  double _promptHeight = 110;
  double _promptOpacity = 1;
  Curve _promptCurve = Curves.bounceOut;
  Duration _promptDuration = const Duration(milliseconds: 500);

  static const Map<JumpType, String> _jumpToString = {
    JumpType.up: "Jump!",
    JumpType.down: "Duck!",
    JumpType.side: "Dodge!",
  };

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    jumpMiniGame.score.addListener(() {
      setState(() {
        scoreCount = jumpMiniGame.score.value;
        _promptDuration = const Duration(milliseconds: 100);
        _promptHeight = 0;
        _promptCurve = Curves.linear;
        _promptOpacity = 0;
      });
    });

    jumpMiniGame.currentTime.addListener(() {
      setState(() {
        timeLeft = minSecDurationToString(jumpMiniGame.getTimeLeft());
      });
    });

    jumpMiniGame.isStopped.addListener(() {
      if (jumpMiniGame.isStopped.value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MiniGameStats(miniGame: jumpMiniGame),
            ));
      }
    });

    jumpMiniGame.currentPrompt.addListener(() {
      setState(() {
        _promptOpacity = 1;
        currentPrompt = jumpMiniGame.currentPrompt.value!;
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
                child: AnimatedOpacity(
                    duration: _promptDuration,
                    opacity: _promptOpacity,
                    child: Image(image: AssetImage(currentPrompt.imagePath)))),
          Column(children: [
            TextButton(
                onPressed: () {
                  SystemChrome.setPreferredOrientations(
                      [DeviceOrientation.landscapeLeft]);
                  jumpMiniGame.stop();
                  jumpMiniGame.dispose();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/caravan", (route) => false);
                },
                child: const Text("Exit")),
            Text("Time Left: $timeLeft",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.none)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AnimatedOpacity(
                  opacity: _promptOpacity,
                  duration: _promptDuration,
                  child: Text(_jumpToString[currentPrompt.requiredType]!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          decoration: TextDecoration.none))),
            )
          ])
        ],
      ),
    );
  }
}
