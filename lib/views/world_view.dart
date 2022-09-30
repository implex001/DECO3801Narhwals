import 'package:caravaneering/games/world_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class WorldView extends StatefulWidget {
  const WorldView({Key? key}) : super(key: key);

  @override
  State<WorldView> createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {

  late WorldGame _game;

  @override
  void initState() {
    _game = WorldGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: _game),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Image.asset("assets/images/UI/Back.png", height: 30),
        ),
      ],
    );
  }
}
