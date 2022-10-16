import 'dart:math';
import 'package:caravaneering/games/caravan_drawables.dart';
import 'package:caravaneering/helpers/convert_asset_path.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'dart:async';
import 'package:flutter/material.dart';

/* 
Renders the animation for the title screen (parallax background, character, horse, cart)
*/
class TitleScreenAnimation extends FlameGame {
  List<Component> currentActors = [];
  late ParallaxComponent<FlameGame> sky;
  late ParallaxComponent<FlameGame> midground;
  late ParallaxComponent<FlameGame> foreground;
  late ParallaxComponent<FlameGame> parallaxGroundDetails;
  late ParallaxComponent<FlameGame> clouds;
  SpriteAnimationComponent charAnimation = SpriteAnimationComponent();

  @override
  Future<void>? onLoad() async {
    // Parallax Background
    camera.speed = 2000;
    sky = await loadParallaxComponent([
      ParallaxImageData('General/ForestSky.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(80, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(sky);
    clouds = await loadParallaxComponent(
        [ParallaxImageData('General/ForestClouds.png')],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(30, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(clouds);
    midground = await loadParallaxComponent([
      ParallaxImageData('General/ForestMidground.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(100, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(midground);
    foreground = await loadParallaxComponent([
      ParallaxImageData('General/ForestForeground.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(70, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(foreground);
    parallaxGroundDetails = await loadParallaxComponent([
      ParallaxImageData('General/ForestDetails.png'),
    ],
        repeat: ImageRepeat.repeatX,
        baseVelocity: Vector2(50, 0),
        velocityMultiplierDelta: Vector2(0.5, 0));
    add(parallaxGroundDetails);

    // Adding the main character and basic horse/cart
    // Characters and Items
    double parallaxRatio = 1080 / camera.viewport.effectiveSize.y;
    double xPosition = 500;

    // Main character
    await images.load("characters/MainCharacterFinal-animation.png");
    var mainCharacter = HumanComponentAnimated("MainCharacterFinal",
        Vector2(xPosition, parallaxRatio * 100 + Random().nextDouble()));
    currentActors.add(mainCharacter);

    // Brown Horse
    xPosition -= 200 + Random().nextDouble() * 5;
    Vector2 horseCoords = Vector2(xPosition, parallaxRatio * 90);
    await images.load("items/horse-brown-animation.png");
    var horseComponent = HorseComponent("horse-brown", horseCoords);
    currentActors.add(horseComponent);

    // Horse Lead
    var horseLeadsImage = await images.load('General/CartToHorse.png');
    Sprite horseLeadSprite = Sprite(horseLeadsImage);
    var horseLeads = SpriteComponent(
        sprite: horseLeadSprite,
        size: Vector2(180, 90),
        position: Vector2(xPosition, parallaxRatio * 90));
    currentActors.add(horseLeads);

    //Cart
    String cartPath = flutterToFlamePath("items/CartFlat.png");
    await images.load(cartPath);
    Vector2 cartCoords = Vector2(xPosition - 40, parallaxRatio * 90);
    var cartComponent = CartComponentAnimated(cartPath, cartCoords);
    currentActors.add(cartComponent);
    addAll(currentActors);
  }
}
