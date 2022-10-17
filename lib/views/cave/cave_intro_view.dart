import 'package:caravaneering/views/jump_minigame_view.dart';
import 'package:caravaneering/views/text_bubble.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/views/cave/creature_icon.dart';
import 'package:caravaneering/model/play_sound.dart';

class CaveIntroView extends StatefulWidget {
  const CaveIntroView({super.key});

  @override
  State<CaveIntroView> createState() => _CaveIntroView();
}

class _CaveIntroView extends State<CaveIntroView> {
  int selectedLevel = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/cave/outside cave.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 50,
          bottom: 15,
          child: Image.asset('assets/images/cave/cave-guide.png', height: 300),
        ),
        Positioned(
            top: 20,
            left: 200,
            child: TextBubble(
              text: "",
              width: 600,
              height: 350,
              fontSize: 20,
            )),
        Positioned(
          left: 270,
          top: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.5,
                child: const CreatureIcon(
                  image: AssetImage(
                    'assets/images/animals/bat badge.png',
                  ),
                  bgColor: Colors.transparent,
                  audio: "audio/bat.mp3",
                ),
              ),
              const Text(
                "\nBat",
                style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 470,
          top: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.5,
                child: const CreatureIcon(
                  image: AssetImage(
                    'assets/images/animals/rat badge.png',
                  ),
                  bgColor: Colors.transparent,
                  audio: "audio/rat.mp3",
                ),
              ),
              const Text(
                "\nRat",
                style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 670,
          top: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.5,
                child: const CreatureIcon(
                  image: AssetImage(
                    'assets/images/animals/snake badge.png',
                  ),
                  bgColor: Colors.transparent,
                  audio: "audio/snake.mp3",
                ),
              ),
              const Text(
                "\nSnake",
                style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          top: 180,
          left: 250,
          child: Text(
            "Listen to the audio cues and move accordingly.\n"
            "Click on the icons above to hear the creature sounds.",
            style: TextStyle(
              fontSize: 18.0,
              decoration: TextDecoration.none,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: 250,
          left: 270,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Game Length:    ",
                style: TextStyle(
                  fontSize: 18.0,
                  decoration: TextDecoration.none,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLevel = 1;
                    });
                  },
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Image.asset("assets/images/placeholders/TextBorder.png",
                        width: 100,
                        color: (selectedLevel != 1) ? Colors.black : null),
                    const Text(
                      "1min",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ])),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLevel = 2;
                    });
                  },
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Image.asset("assets/images/placeholders/TextBorder.png",
                        width: 100,
                        color: (selectedLevel != 2) ? Colors.black : null),
                    const Text(
                      "2min",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ])),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLevel = 5;
                    });
                  },
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Image.asset("assets/images/placeholders/TextBorder.png",
                        width: 100,
                        color: (selectedLevel != 5) ? Colors.black : null),
                    const Text(
                      "5min",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ])),
            ],
          ),
        ),
        Positioned(
          left: 250,
          top: 300,
          child: Container(
            width: 500,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: () {
                      PlaySoundUtil.instance().play("audio/button_click.mp3");
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Container(
                      height: 38,
                      width: 88,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/UI/Back.png'),
                          //fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      PlaySoundUtil.instance().play("audio/button_click.mp3");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                JumpMiniGameView(selectedTime: selectedLevel),
                          ));
                    },
                    child: Container(
                      height: 38,
                      width: 88,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/UI/play.png'),
                          //fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
