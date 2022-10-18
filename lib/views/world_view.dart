import 'dart:math';

import 'package:caravaneering/games/world_game.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/story.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caravaneering/model/play_sound.dart';

/// View for the world map
class WorldView extends StatefulWidget {
  const WorldView({Key? key}) : super(key: key);

  @override
  State<WorldView> createState() => _WorldViewState();
}

class _WorldViewState extends State<WorldView> {
  late WorldGame _game;
  Episode? _episode;

  @override
  void initState() {
    _game = WorldGame((Episode e) => setState(() => _episode = e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GameWidget(game: _game),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          GestureDetector(
            onTap: () {
              PlaySoundUtil.instance().play("audio/button_click.mp3");
              Navigator.pop(context);
            },
            child: Image.asset("assets/images/UI/Back.png", height: 30),
          ),
          if (_episode != null)
            Stack(
              children: [
                SizedBox(
                  height: 30,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Consumer<SaveModel>(
                    builder: (context, save, child) {
                      int lifetimeSteps = save.get(SaveKeysV1.lifeTimeSteps);
                      double progress =
                          min(lifetimeSteps / _episode!.requiredSteps, 1);
                      return LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        minHeight: 30,
                      );
                    },
                  ),
                ),
                Consumer<SaveModel>(
                  builder: (context, save, child) {
                    int lifetimeSteps = save.get(SaveKeysV1.lifeTimeSteps);
                    double progress =
                        min(lifetimeSteps / _episode!.requiredSteps, 1);
                    return Container(
                      padding: const EdgeInsets.only(left: 10, top: 2),
                      child: Text(
                        "${_episode!.id}: ${lifetimeSteps} / ${_episode!.requiredSteps} "
                        "steps (${(progress * 100).toStringAsFixed(0)}%)",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
        ]),
        if (_episode != null)
          Consumer<SaveModel>(builder: (context, save, child) {
            int lifetimeSteps = save.get(SaveKeysV1.lifeTimeSteps);
            double progress = min(lifetimeSteps / _episode!.requiredSteps, 1);
            if (progress >= 1) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    PlaySoundUtil.instance().play("audio/button_click.mp3");
                    _game.playEpisode(_episode!);
                    },
                    child: Image.asset("assets/images/UI/play.png", height: 30),
                ),
              );
            } else {
              return const SizedBox();
            }
          })
      ],
    );
  }
}
