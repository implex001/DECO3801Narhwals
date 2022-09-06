import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'dart:async';
//import 'package:caravaneering/views/title_screen.dart';
import 'package:flutter/material.dart';

class TitleScreenAnimation extends FlameGame {
  static const String description = '''
    Caravan Game
  ''';

  late ParallaxComponent<FlameGame> parallaxComponent;
  SpriteAnimationComponent charAnimation = SpriteAnimationComponent();

  @override
  Future<void>? onLoad() async {
    camera.speed = 2000;
    parallaxComponent = await loadParallaxComponent([
      ParallaxImageData('General/CaravanBackground.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(50, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(parallaxComponent);

    var _image = await images.load('General/HorseBlack.png');
    Sprite T1 = Sprite(_image);
    final player = SpriteComponent(
        sprite: T1, size: Vector2(10, 10), position: Vector2(100, 200));
    add(player);

    var character = await images.load('General/MainCharacterFinal.png');
    final spiteSize = Vector2(152 * 1.4, 142 * 1.4);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 9, stepTime: 0.03, textureSize: Vector2(152.0, 142.0));
    var characterAnimation =
        SpriteAnimationComponent.fromFrameData(character, spriteData)
          ..x = 150
          ..y = 30
          ..size = spiteSize;
    //add(characterAnimation);
  }

  @override
  Color backgroundColor() {
    return const Color(0xFFFFFFFF);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
