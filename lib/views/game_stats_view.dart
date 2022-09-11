import 'package:caravaneering/games/jump_minigame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MiniGameStats extends StatefulWidget {
  const MiniGameStats({super.key, required this.miniGame});
  final JumpMiniGame miniGame;

  @override
  State<MiniGameStats> createState() => _StatsView(miniGame: miniGame);
}

class _StatsView extends State<MiniGameStats> {
  _StatsView({Key? key, required this.miniGame});
  final JumpMiniGame miniGame;
  late ValueNotifier<int> score = miniGame.score;
  late Duration time = miniGame.timeTotal;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: Colors.blueGrey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                      child: DefaultTextStyle(
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 35,
                        backgroundColor: Colors.black),
                    child: Text(
                      ' CONGRATULATIONS ',
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Center(
                      child: DefaultTextStyle(
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    child: Text(
                      'You played for a total time of ${time.inSeconds} seconds.',
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Center(
                      child: DefaultTextStyle(
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                    child: Text(
                      'You have earned a total score of ${score.value.toString()}.',
                      textAlign: TextAlign.center,
                    ),
                  )),
                  Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/minigames", (route) => false);
                            },
                            child: Image.asset(
                              'assets/images/UI/Minigames.png',
                              fit: BoxFit.contain,
                              height: 30,
                            )),
                      ]))
                ])),
        Positioned(
          bottom: 30,
          left: 30,
          height: 250,
          width: 250,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/cave/cave-guide.png'),
            )),
          ),
        )
      ],
    );
  }
}
