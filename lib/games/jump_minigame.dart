import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:caravaneering/games/minigame.dart';
import 'package:caravaneering/model/jump_tracker.dart';
import 'package:flutter/material.dart';

class JumpMiniGame extends MiniGame{

  final JumpTracker _tracker;
  late StreamSubscription jumpStream;

  static const prompts = [
    JumpPrompt(JumpType.up, "audio/sine.mp3"),
    JumpPrompt(JumpType.up, "audio/sine2.mp3")
  ];

  late Timer timeLimit;
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<bool> isStopped = ValueNotifier(false);
  JumpPrompt? currentPrompt;


  JumpMiniGame(Duration time)
      : _tracker = JumpTracker()
  {
     timeLimit = Timer(time, stop);
  }

  @override
  void resume() {
    jumpStream.resume();
  }

  @override
  void pause() {
    jumpStream.pause();
  }

  @override
  void start() async {
    // Set up cache
    AudioCache.instance.loadAll(prompts.map((e) => e.path).toList());

    // Set initial jump prompt
    currentPrompt = _getRandomPrompt();
    _playSound(currentPrompt!.path);

    jumpStream = _tracker.getJumpStream().listen((event) {
      if (currentPrompt?.requiredType == event.type) {
        score.value++;
        currentPrompt = null;
        _playSound("audio/sineup.mp3");
        Timer(const Duration(seconds: 3), () {
          currentPrompt = _getRandomPrompt();
          _playSound(currentPrompt!.path);
        }
        );
      }
    });
  }

  @override
  void stop() {
    jumpStream.cancel();
    isStopped.value = true;
  }

  JumpPrompt _getRandomPrompt() {
    return prompts[Random().nextInt(prompts.length)];
  }

  void _playSound(String path) {
    final player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.play(AssetSource(path));
  }

}

class JumpPrompt {
  final JumpType requiredType;
  final String path;
  const JumpPrompt(this.requiredType, this.path);
}