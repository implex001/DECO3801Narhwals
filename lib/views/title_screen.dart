import 'package:caravaneering/views/caravan_view.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../games/title_game.dart';
import 'package:caravaneering/main.dart';
import 'play_sound.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TitleScreen();
  }
}

class _TitleScreen extends StatelessWidget {
  final game = TitleScreenAnimation();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          PlaySoundUtil.instance().play("audio/start.mp3");
          Navigator.pushNamedAndRemoveUntil(
              context, "/caravan", (route) => false);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            GameWidget(game: TitleScreenAnimation()),
            Positioned(
                top: 250,
                left: 200,
                child: Image.asset(
                    'assets/images/General/AnimatedHorseCart.gif',
                    height: 100,
                    fit: BoxFit.contain)),
            Positioned(
                top: 280,
                left: 450,
                child: Image.asset(
                  'assets/images/General/AnimatedCharacter.gif',
                  height: 70,
                  fit: BoxFit.contain,
                )),
            Container(
                width: 450.0,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/General/Logo.png',
                    height: 200,
                  ),
                )),
            const Positioned(
                bottom: 20,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                      child: Text(
                        'Click anywhere to start...',
                        textAlign: TextAlign.center,
                      ),
                    )))
            //Positioned
          ], //<Widget>[]
        ));
  }
}
