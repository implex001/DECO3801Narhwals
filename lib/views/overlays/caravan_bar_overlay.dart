import 'package:caravaneering/games/caravan_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget caravanBarOverlay(BuildContext buildContext, CaravanGame game) {
  return CaravanBarOverlay();
}

class CaravanBarOverlay extends StatelessWidget {

  CaravanBarOverlay({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Row (
          children: [
            TextButton(onPressed: (){} , child: Text("Menu")),
            TextButton(onPressed: (){}, child: Text("Shop")),
            TextButton(onPressed: (){}, child: Text("Skills")),
            TextButton(onPressed: (){}, child: Text("Caravan")),
            const Spacer(),
            Consumer<SaveModel>(builder: (context, save, child) {
              return Text(
                '${save.get(SaveKeysV1.coins)}',
                  style: Theme.of(context).textTheme.headline4
              );
            })
          ]
      );
  }

}
