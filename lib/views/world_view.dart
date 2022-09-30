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
    return GameWidget(game: _game);
  }
}
