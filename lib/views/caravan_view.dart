import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/views/coin_collect_animation.dart';
import 'package:caravaneering/views/overlays/caravan_step_update_overlay.dart';
import 'package:caravaneering/views/overlays/navbar_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// View to display a [CaravanGame] instance
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
    return Provider(
      create: (context) => _game,
      child: GameWidget(
        game: _game,
        overlayBuilderMap: const {
          "Bar": flameNavbarOverlay,
          "StepUpdate": caravanStepUpdate,
          "Coins": coinOverlay,
        },
        initialActiveOverlays: const ["Bar"],
      ),
    );
  }
}
