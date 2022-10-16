import 'package:caravaneering/games/jump_minigame.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/views/coin_collect_animation.dart';
import 'package:caravaneering/views/overlays/navbar_overlay.dart';
import 'package:caravaneering/views/text_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:caravaneering/model/play_sound.dart';

class ChatBubbleTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.blue;
    var path = Path();
    path.lineTo(-10, 0);
    path.lineTo(0, 10);
    path.lineTo(10, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// Minigame outro to show rewards and statistics of played minigame
/// Currently hardcoded to [JumpMinigame]
class MinigameOutro extends StatefulWidget {
  MinigameOutro({Key? key, required this.miniGame});

  final JumpMiniGame miniGame;

  @override
  State<MinigameOutro> createState() => _MinigameOutro();
}

class _MinigameOutro extends State<MinigameOutro> {
  late JumpMiniGame miniGame;
  late CoinCollectAnimation coinCollectAnimation;

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
        PlaySoundUtil.instance().play("audio/button_click.mp3");
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
              top: 140,
              right: 80,
              child: Image.asset(
                  'assets/images/characters/MainCharacterForward.png',
                  width: 140)),
          Positioned(
              top: 150,
              left: 50,
              child:
                  Image.asset('assets/images/cave/cave-guide.png', width: 80)),
          Positioned(
              top: 10,
              left: 200,
              child: TextBubble(
                text: "",
                width: 400,
                height: 100,
                fontSize: 20,
              )),
          const Positioned(
              top: 40,
              left: 280,
              child: Text('Congratulations!',
                  style: TextStyle(
                      fontSize: 30.0,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.w700))),
          Positioned(
              left: 340,
              bottom: 60,
              child: Image.asset(
                'assets/images/cave/chest_1.png',
                fit: BoxFit.contain,
                height: 150,
              )),
        ],
      ),
    );
  }
}

/// Shows statistics of [JumpMiniGame]
class MiniGameStats extends StatefulWidget {
  const MiniGameStats({super.key, required this.miniGame});

  final JumpMiniGame miniGame;

  @override
  State<MiniGameStats> createState() => StatsView();
}

class StatsView extends State<MiniGameStats> {
  StatsView({Key? key});

  late ValueNotifier<int> score = widget.miniGame.score;
  late Duration time = widget.miniGame.currentTime.value;

  late int? modifier;
  late int coinsEarned;
  late int obstacleCoins;
  late bool showCoinAnimation;

  @override
  void initState() {
    super.initState();
    showCoinAnimation = false;
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      setState(() {
        showCoinAnimation = true;
        Provider.of<SaveModel>(context, listen: false).addCoins(coinsEarned);
        Provider.of<SaveModel>(context, listen: false).saveState();
        PlaySoundUtil.instance().play("audio/coins_1sec_consistent.mp3");
      });
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    modifier = Provider.of<SaveModel>(context, listen: false)
        .get(SaveKeysV1.groupUpgrades);
    modifier = (modifier == null) ? 1 : modifier;
    obstacleCoins = score.value * 50;
    coinsEarned = (200 + obstacleCoins) * modifier!;
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
            top: 140,
            right: 80,
            child: Image.asset(
                'assets/images/characters/MainCharacterForward.png',
                width: 140)),
        Positioned(
            top: 150,
            left: 50,
            child: Image.asset('assets/images/cave/cave-guide.png', width: 80)),
        Positioned(
            top: 7,
            left: 180,
            child: TextBubble(
              text: "",
              width: 500,
              height: 170,
              fontSize: 20,
            )),
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
                    color: Colors.transparent,
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$obstacleCoins',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text('200',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${modifier}x',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
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
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('$coinsEarned',
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700))
                        ]),
                  ]),
                ])),
          ),
        ),
        Positioned(
            left: 340,
            bottom: 60,
            child: Image.asset(
              'assets/images/cave/coin_chest.gif',
              fit: BoxFit.contain,
              height: 150,
            )),
        Positioned(
          left: 360,
          bottom: 20,
          child: GestureDetector(
              onTap: () {
                PlaySoundUtil.instance().play("audio/button_click.mp3");
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Image.asset(
                'assets/images/UI/Back.png',
                fit: BoxFit.contain,
                height: 30,
              )),
        ),
        const CoinDisplayBar(),
        FutureBuilder(
            builder: (context, snapshot) => showCoinAnimation
                ? CoinCollectAnimation(
                    startLeft: 352,
                    startTop: 233,
                    startTurn: 0,
                    endTop: MediaQuery.of(context).size.height / 40,
                    endLeft: MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width / 5,
                    endTurn: 20,
                    numCoins: 10,
                    endScale: 0.05,
                  )
                : Container())
      ],
    );
  }
}
