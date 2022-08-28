

import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget caravanStepUpdate(BuildContext buildContext, CaravanGame game) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("You have stepped ${game.backgroundSteps} while you were away"),
    )
  );
}