import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:caravaneering/games/minigame.dart';
import 'package:caravaneering/model/jump_tracker.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

/// Model and underlying logic for the jump minigame
class JumpMiniGame extends MiniGame {
  final JumpTracker _tracker;
  late StreamSubscription jumpStream;

  static const prompts = [
    JumpPrompt(JumpType.side, "audio/rat.mp3", "assets/images/animals/Rat.png"),
    JumpPrompt(
        JumpType.up, "audio/snake.mp3", "assets/images/animals/Snake.png"),
    JumpPrompt(JumpType.down, "audio/bat.mp3", "assets/images/animals/Bat.png"),
  ];

  static const Duration timeUpdateFreq = Duration(seconds: 1);

  late Timer timeLimit;
  Duration timeTotal;
  ValueNotifier<Duration> currentTime;
  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<bool> isStopped = ValueNotifier(false);
  ValueNotifier<JumpPrompt?> currentPrompt = ValueNotifier(null);
  bool promptCompleted = false;

  final Random _random = Random();
  final backgroundPlayer = AudioPlayer();

  JumpMiniGame(this.timeTotal)
      : _tracker = JumpTracker(),
        currentTime = ValueNotifier(Duration.zero) {
    timeLimit = Timer.periodic(timeUpdateFreq, _checkTimeLeft);
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
    AudioCache.instance.loadAll(prompts.map((e) => e.audioPath).toList());

    //Play background music
    backgroundPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    backgroundPlayer.play(AssetSource("audio/music-minigame.mp3"));
    

    // Set initial jump prompt
    _promptTimerCallback();

    //Check vibrator
    bool? hasVibrator = await Vibration.hasVibrator();
    hasVibrator ??= false;

    // Set jump stream
    jumpStream = _tracker.getJumpStream().listen((event) {
      if (hasVibrator!) {
        Vibration.vibrate(duration: 50);
      }

      if (!promptCompleted) {
        score.value++;
        promptCompleted = true;
      }
    });
  }

  @override
  void stop() {
    jumpStream.cancel();
    timeLimit.cancel();
    backgroundPlayer.stop();
    isStopped.value = true;
  }

  @override
  void dispose() {
    jumpStream.cancel();
    timeLimit.cancel();
    backgroundPlayer.stop();
    backgroundPlayer.dispose();
  }

  @override
  String getDescription() {
    return "Jump and step your way through a dungeon";
  }

  Duration getTimeLeft() {
    return timeTotal - currentTime.value;
  }

  void _checkTimeLeft(Timer timer) {
    currentTime.value += timeUpdateFreq;
    if (currentTime.value >= timeTotal) {
      if (isStopped.value == false) {
        backgroundPlayer.setReleaseMode(ReleaseMode.stop);
        backgroundPlayer.play(AssetSource("audio/win.mp3"));
      }
      stop();
    }
  }

  void _promptTimerCallback() {
    if (!isStopped.value) {
      currentPrompt.value = _getRandomPrompt();
      _playSound(currentPrompt.value!.audioPath);
      promptCompleted = false;
      Timer(Duration(milliseconds: _random.nextInt(3000) + 2000),
          _promptTimerCallback);
    }
  }

  JumpPrompt _getRandomPrompt() {
    var tempPrompt = prompts[_random.nextInt(prompts.length)];
    if (tempPrompt == currentPrompt.value) {
      return _getRandomPrompt();
    }
    return tempPrompt;
  }

  void _playSound(String path) {
    final player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.play(AssetSource(path));
  }
}

class JumpPrompt {
  final JumpType requiredType;
  final String audioPath;
  final String imagePath;

  const JumpPrompt(this.requiredType, this.audioPath, this.imagePath);
}
