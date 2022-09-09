import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

import 'package:caravaneering/views/overlays/navbar_overlay.dart';

class CaveIntroView extends StatefulWidget {
  const CaveIntroView({Key? key}) : super(key: key);

  @override
  State<CaveIntroView> createState() => _CaveIntroViewState();
}

class _CaveIntroViewState extends State<CaveIntroView> {
  CaravanGame? game;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (game == null) {
      if (ModalRoute.of(context) != null) {
        Map args = ModalRoute
            .of(context)!
            .settings
            .arguments as Map;
        game = args["game"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Center(
              child: Container(
                color: Colors.teal[800],
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
                                  image: AssetImage('assets/images/cave/cave-guide.png'),
                                  fit: BoxFit.contain,
                                )
                            ),
                        ),
                      )
                    ),
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
                                  child: Column(
                                    children: <Widget> [
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            CreatureIcon(
                                              image: AssetImage('assets/images/cave/snake.png'),
                                              bgColor: Colors.green[800]!,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            CreatureIcon(
                                              image: AssetImage('assets/images/cave/bat.png'),
                                              bgColor: Colors.blue[300]!,
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            CreatureIcon(
                                              image: AssetImage('assets/images/cave/rat.png'),
                                              bgColor: Colors.red[300]!,
                                            ),
                                          ]
                                        )
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, "/minigames/jump", (route) => false
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 88,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/UI/play.png'),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ]
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                      children: [
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
                                      ]
                                  ),
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
          (game == null) ? Container() : navbarOverlay(context, game!),
        ]
    );
  }
}

class CreatureIcon extends StatelessWidget {
  const CreatureIcon({Key? key, required this.image, required this.bgColor}) : super(key: key);
  final AssetImage image;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 60),
      child: GestureDetector(
        onTap: () {},
        child: AspectRatio(
          aspectRatio: 1/1,
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

