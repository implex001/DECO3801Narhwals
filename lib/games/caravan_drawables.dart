import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:caravaneering/model/pet_animation_details.dart';

// These components assume that there respective images are loaded

class HorseComponent extends SpriteAnimationComponent{
  HorseComponent(String horseKey, Vector2 position) : super.fromFrameData(
    Flame.images.fromCache("items/$horseKey-animation.png"),
    SpriteAnimationData.sequenced(
      textureSize: Vector2(260,225),
      amount: 4,
      amountPerRow: 2,
      stepTime: 0.2,
    ),
    size: Vector2(100, 86.54),
    position: position,
  );
}

class CartComponent extends SpriteAnimationComponent{
  CartComponent(String cartKey, Vector2 position) : super.fromFrameData(
    Flame.images.fromCache("items/$cartKey.png"),
    SpriteAnimationData.sequenced(
      textureSize: Vector2(242,256),
      amount: 1,
      amountPerRow: 1,
      stepTime: 0.2,
    ),
    size: Vector2(80, 106),
    position: position
  );
}

class HumanComponentAnimated extends SpriteAnimationComponent{
  HumanComponentAnimated(String humanKey, Vector2 position) : super.fromFrameData(
    Flame.images.fromCache("characters/$humanKey-animation.png"),
    SpriteAnimationData.sequenced(
      textureSize: Vector2(192,192),
      amount: 2,
      amountPerRow: 2,
      stepTime: 0.5,
    ),
    size: Vector2(60, 60),
    position: position,
  );
}

class HumanComponent extends SpriteAnimationComponent{
  HumanComponent(String humanKey, Vector2 position) : super.fromFrameData(
    Flame.images.fromCache("characters/$humanKey.png"),
    SpriteAnimationData.sequenced(
      textureSize: Vector2(256,256),
      amount: 1,
      amountPerRow: 1,
      stepTime: 0.5,
    ),
    size: Vector2(60, 60),
    position: position,
  );
}

class PetComponent extends SpriteAnimationComponent{
  PetComponent(String petKey) : super.fromFrameData(
    Flame.images.fromCache("items/$petKey-animation.png"),
    SpriteAnimationData.sequenced(
      textureSize: PetAnimationDetails.pets[petKey]!["spriteSize"],
      amount: PetAnimationDetails.pets[petKey]!["animationCount"],
      amountPerRow: PetAnimationDetails.pets[petKey]!["animationCount"],
      stepTime: PetAnimationDetails.pets[petKey]!["stepTime"],
    ),
    size: PetAnimationDetails.pets[petKey]!["size"],
    position: PetAnimationDetails.pets[petKey]!["position"],
  );
}

