import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget caravanStepUpdate(BuildContext buildContext, CaravanGame game) {
  return Center(
    child: DefaultTextStyle(
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: 40,
      ),
      child: Text("${game.backgroundSteps} Steps"),
    ),
  );
}
