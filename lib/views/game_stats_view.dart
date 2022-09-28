import 'package:caravaneering/games/jump_minigame.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/views/overlays/navbar_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MinigameOutro extends StatefulWidget {
  MinigameOutro({Key? key, required this.miniGame});
  final JumpMiniGame miniGame;

  @override
  State<MinigameOutro> createState() => _MinigameOutro();
}

class _MinigameOutro extends State<MinigameOutro> {
  late JumpMiniGame miniGame;
  @override
  void initState() {
    super.initState();
    miniGame = widget.miniGame;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MiniGameStats(miniGame: miniGame),
            ));
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/cave/inside_cave.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
              top: 160,
              right: 50,
              child: Image.asset(
                  'assets/images/characters/MainCharacterFinalFlipped.png',
                  width: 200)),
          Positioned(
              top: 150,
              left: 50,
              child:
                  Image.asset('assets/images/cave/cave-guide.png', width: 80)),
          Positioned(
              left: 370,
              bottom: 70,
              child: Image.asset(
                'assets/images/cave/chest_1.png',
                fit: BoxFit.contain,
                height: 150,
              )),
          const Positioned(
            top: 50,
            left: 280,
            child: Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 30.0,
                decoration: TextDecoration.none,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MiniGameStats extends StatefulWidget {
  const MiniGameStats({super.key, required this.miniGame});
  final JumpMiniGame miniGame;

  @override
  State<MiniGameStats> createState() => StatsView(miniGame: miniGame);
}

class StatsView extends State<MiniGameStats> {
  StatsView({Key? key, required this.miniGame});
  final JumpMiniGame miniGame;
  late ValueNotifier<int> score = miniGame.score;
  late Duration time = miniGame.currentTime.value;

  late int? modifier;
  late int coinsEarned;
  late int obstacleCoins;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    modifier = Provider.of<SaveModel>(context, listen: false)
        .get(SaveKeysV1.groupUpgrades);
    modifier = (modifier == null) ? 1 : modifier;
    obstacleCoins = score.value;
    coinsEarned = (500 + 10 + score.value) * modifier!;
    Provider.of<SaveModel>(context, listen: false).addCoins(coinsEarned);
    Provider.of<SaveModel>(context, listen: false).saveState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/images/cave/inside_cave.png',
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
            top: 160,
            right: 50,
            child: Image.asset(
                'assets/images/characters/MainCharacterFinalFlipped.png',
                width: 200)),
        Positioned(
            top: 150,
            left: 50,
            child: Image.asset('assets/images/cave/cave-guide.png', width: 80)),
        Positioned(
          top: 30,
          left: 230,
          child: Container(
            height: 150,
            width: 400,
            color: Colors.transparent,
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    )),
                child: Table(children: [
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Obstacle Coins',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$obstacleCoins',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ]),
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Completion Coins',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('500',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ]),
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Multiplier',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${modifier}x',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ]),
                  TableRow(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Total',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$coinsEarned',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ]),
                ])),
          ),
        ),
        Positioned(
          left: 370,
          bottom: 70,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/caravan", (route) => false);
              },
              child: Image.asset(
                'assets/images/cave/coin_chest.gif',
                fit: BoxFit.contain,
                height: 150,
              )),
        ),
        Positioned(
          left: 385,
          bottom: 20,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/caravan", (route) => false);
              },
              child: Image.asset(
                'assets/images/UI/Back.png',
                fit: BoxFit.contain,
                height: 30,
              )),
        ),
        const CoinDisplayBar(),
      ],
    );
  }
}
