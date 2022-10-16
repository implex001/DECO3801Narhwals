import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

/// Icon with circular icons for creatures
class CreatureIcon extends StatelessWidget {
  const CreatureIcon(
      {Key? key,
      required this.image,
      required this.bgColor,
      required this.audio})
      : super(key: key);
  final AssetImage image;
  final Color bgColor;
  final String audio;

  void _playSound(String path) {
    final player = AudioPlayer();
    player.setPlayerMode(PlayerMode.lowLatency);
    player.play(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 60),
      child: GestureDetector(
        onTap: () {
          _playSound(audio);
        },
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
