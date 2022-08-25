import 'package:caravaneering/games/caravan_game.dart';
import 'package:flutter/material.dart';

Widget caravanBarOverlay(BuildContext buildContext, CaravanGame game) {
  return Row (
    children: [
      TextButton(onPressed: (){} , child: Text("Menu")),
      TextButton(onPressed: (){}, child: Text("Shop")),
      TextButton(onPressed: (){}, child: Text("Skills")),
      TextButton(onPressed: (){}, child: Text("Caravan")),
    ],
  );
}