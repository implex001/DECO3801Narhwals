
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

class PlaySoundUtil {

  late AudioPlayer player;
  static PlaySoundUtil? _single;
  PlaySoundUtil._(){
      player = AudioPlayer();
  }

  static PlaySoundUtil instance(){
    return _single ??= PlaySoundUtil._();
  }


  void play(String path) async {
    final source = AssetSource(path);
    await player.stop();
    await player.play(source);
  }

}
