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
  late ParallaxComponent<FlameGame> parallaxComponent2;
  late ParallaxComponent<FlameGame> parallaxComponent3;
  late ParallaxComponent<FlameGame> parallaxGroundDetails;
  SpriteAnimationComponent charAnimation = SpriteAnimationComponent();

  @override
  Future<void>? onLoad() async {
    camera.speed = 2000;
    parallaxComponent = await loadParallaxComponent([
      ParallaxImageData('General/Sky.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(80, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(parallaxComponent);
    parallaxComponent2 = await loadParallaxComponent([
      ParallaxImageData('General/Midground.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(100, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(parallaxComponent2);
    parallaxComponent3 = await loadParallaxComponent([
      ParallaxImageData('General/Foreground.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(70, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(parallaxComponent3);
    parallaxGroundDetails = await loadParallaxComponent([
      ParallaxImageData('General/Details.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(50, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(parallaxGroundDetails);

    var character = await images.load('characters/MainCharacterFinal.png');
    final spiteSize = Vector2(152 * 1.4, 142 * 1.4);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 9, stepTime: 0.03, textureSize: Vector2(152.0, 142.0));
    var characterAnimation =
        SpriteAnimationComponent.fromFrameData(character, spriteData)
          ..x = 150
          ..y = 30
          ..size = spiteSize;
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
