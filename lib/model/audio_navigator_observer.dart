import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

/// Controls states of background audio players based on current navigation
class AudioNavigatorObserver extends NavigatorObserver {
  final backgroundPlayer = AudioPlayer();
  final ambiancePlayer = AudioPlayer();

  AudioNavigatorObserver() {
    backgroundPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    ambiancePlayer.setPlayerMode(PlayerMode.mediaPlayer);
    ambiancePlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    switch (route.settings.name) {
      case '/':
        if (ambiancePlayer.state == PlayerState.playing ||
            backgroundPlayer.state == PlayerState.playing) {
          backgroundPlayer.stop();
          ambiancePlayer.stop();
        }
        backgroundPlayer.play(AssetSource("audio/music-main.mp3"));
        ambiancePlayer.play(AssetSource("audio/mainscreen-ambiance.mp3"));
        break;
      case '/cave-intro':
        if (ambiancePlayer.state == PlayerState.playing ||
            backgroundPlayer.state == PlayerState.playing) {
          backgroundPlayer.stop();
          ambiancePlayer.stop();
        }
        ambiancePlayer.play(AssetSource("audio/cave-ambiance.mp3"));
        break;
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    switch (route.settings.name) {
      //Coming back from cave intro to caravan, not a long term solution
      case '/cave-intro':
        backgroundPlayer.stop();
        ambiancePlayer.stop();
        backgroundPlayer.play(AssetSource("audio/music-main.mp3"));
        ambiancePlayer.play(AssetSource("audio/mainscreen-ambiance.mp3"));
        break;
    }
  }
}
