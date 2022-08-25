import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/views/overlays/caravan_bar_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class CaravanView extends StatefulWidget {
  const CaravanView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CaravanView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CaravanView> {

  late CaravanGame _game;

  @override
  void initState() {
    _game = CaravanGame();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
        GameWidget(
            game: _game,
            overlayBuilderMap: const {
              "Bar": caravanBarOverlay
            },
            initialActiveOverlays: const ['Bar']
        ),
    );
  }

}