import 'package:audioplayers/audioplayers.dart';

/// Singleton class to play sounds
class PlaySoundUtil {
  late AudioPlayer player;
  static PlaySoundUtil? _single;

  PlaySoundUtil._() {
    player = AudioPlayer();
  }

  /// Get the singleton instance
  static PlaySoundUtil instance() {
    return _single ??= PlaySoundUtil._();
  }

  /// Play a sound. Interrupts previous sound playing
  void play(String path) async {
    final source = AssetSource(path);
    await player.stop();
    await player.play(source);
  }
}
