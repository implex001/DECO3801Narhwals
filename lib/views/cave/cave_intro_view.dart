import 'package:caravaneering/views/jump_minigame_view.dart';
import 'package:caravaneering/views/text_bubble.dart';
import 'package:flutter/material.dart';
import 'package:caravaneering/views/cave/creature_icon.dart';
import 'package:caravaneering/play_sound.dart';

late int selectedLevel;

class CaveIntroView extends StatefulWidget {
  const CaveIntroView({super.key});

  @override
  State<CaveIntroView> createState() => _CaveIntroView();
}

class _CaveIntroView extends State<CaveIntroView> {
  @override
  void initState() {
    super.initState();
    selectedLevel = 1;
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
                        color: (selectedLevel != 1)
                            ? Color.fromRGBO(
                                0,
                                0,
                                0,
                                0,
                              )
                            : null),
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
                        color: (selectedLevel != 2)
                            ? Color.fromRGBO(
                                0,
                                0,
                                0,
                                0,
                              )
                            : null),
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
                        color: (selectedLevel != 5)
                            ? Color.fromRGBO(
                                0,
                                0,
                                0,
                                0,
                              )
                            : null),
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

  /*
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cave/outside cave.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image:
                              AssetImage('assets/images/cave/cave-guide.png'),
                          fit: BoxFit.contain,
                        )),
                      ),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Container(
                      color: Colors.brown[500],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Column(children: <Widget>[
                                Expanded(
                                    child: Column(children: <Widget>[
                                  CreatureIcon(
                                    image: const AssetImage(
                                        'assets/images/cave/snake.png'),
                                    bgColor: Colors.green[800]!,
                                    audio: "audio/snake.mp3",
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  CreatureIcon(
                                    image: const AssetImage(
                                        'assets/images/cave/bat.png'),
                                    bgColor: Colors.blue[300]!,
                                    audio: "audio/bat.mp3",
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  CreatureIcon(
                                    image: const AssetImage(
                                        'assets/images/cave/rat.png'),
                                    bgColor: Colors.red[300]!,
                                    audio: "audio/rat.mp3",
                                  ),
                                ])),
                              ]),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(children: [
                                Text(
                                  "There be treasure ahead!",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    decoration: TextDecoration.none,
                                    color: Colors.orange[200],
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "I have heard there is treasure in a nearby cave; however, beware there are rumours of dangerous creatures lurking inside!",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    decoration: TextDecoration.none,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "How to play:",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    decoration: TextDecoration.none,
                                    color: Colors.orange[200],
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Welcome to the exercise minigame where you will be physically dodging and ducking "
                                  "dangerous creatures to take the treasure from the dark cave. As the cave is "
                                  "pitch black, you will have to listen out for dangerous sounds and then react "
                                  "quickly!\n\n"
                                  "Instructions: Jump over the snakes, duck the bats, dodge out of the way of the giant rat (side step)\n\n"
                                  "Click the icons to the right to hear the creature sounds.",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    decoration: TextDecoration.none,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                // Difficulty Selector
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Length",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        decoration: TextDecoration.none,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedLevel = 1;
                                          });
                                          //selectedLevel = 3;
                                        },
                                        child: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Image.asset(
                                                  "assets/images/placeholders/TextBorder.png",
                                                  width: 100,
                                                  color: (selectedLevel != 1)
                                                      ? Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                        )
                                                      : null),
                                              Text(
                                                "1min",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 12.0,
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ])),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedLevel = 2;
                                          });
                                          //selectedLevel = 2;
                                        },
                                        child: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Image.asset(
                                                  "assets/images/placeholders/TextBorder.png",
                                                  width: 100,
                                                  color: (selectedLevel != 2)
                                                      ? Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                        )
                                                      : null),
                                              Text(
                                                "2min",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 12.0,
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ])),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedLevel = 5;
                                          });
                                          //selectedLevel = 3;
                                        },
                                        child: Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Image.asset(
                                                  "assets/images/placeholders/TextBorder.png",
                                                  width: 100,
                                                  color: (selectedLevel != 5)
                                                      ? Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0,
                                                        )
                                                      : null),
                                              Text(
                                                "5min",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 12.0,
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ])),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          PlaySoundUtil.instance().play("audio/button_click.mp3");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CaravanView(
                                                          title: "title")));
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 88,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/UI/Back.png'),
                                              //fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JumpMiniGameView(
                                                        selectedTime:
                                                            selectedLevel),
                                              ));
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 88,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/UI/play.png'),
                                              //fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      const NavBar(),
    ]);
  }
  */
}
