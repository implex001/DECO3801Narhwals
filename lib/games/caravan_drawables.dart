import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:caravaneering/model/pet_animation_details.dart';

/// Horse component
///
/// This component assume that their respective images are loaded
class HorseComponent extends SpriteAnimationComponent {
  HorseComponent(String horseKey, Vector2 position)
      : super.fromFrameData(
          Flame.images.fromCache("items/$horseKey-animation.png"),
          SpriteAnimationData.sequenced(
            textureSize: Vector2(300, 128),
            amount: 4,
            amountPerRow: 4,
            stepTime: 0.2,
          ),
          size: Vector2(225, 96),
          position: position,
        );
}

/// Donkey component
///
/// This component assume that their respective images are loaded
class DonkeyComponent extends SpriteAnimationComponent {
  DonkeyComponent(String donkeyKey, Vector2 position)
      : super.fromFrameData(
          Flame.images.fromCache("items/$donkeyKey-animation.png"),
          SpriteAnimationData.sequenced(
            textureSize: Vector2(64, 64),
            amount: 4,
            amountPerRow: 4,
            stepTime: 0.2,
          ),
          size: Vector2(96, 96),
          position: position,
        );
}

/// Cart component
///
/// This component assume that their respective images are loaded
class CartComponent extends SpriteAnimationComponent {
  CartComponent(String imagePath, Vector2 position)
      : super.fromFrameData(
            Flame.images.fromCache(imagePath),
            SpriteAnimationData.sequenced(
              textureSize: Vector2(242, 256),
              amount: 1,
              amountPerRow: 1,
              stepTime: 0.2,
            ),
            size: Vector2(80, 106),
            position: position);
}

/// Animated cart component
///
/// This component assume that their respective images are loaded
class CartComponentAnimated extends SpriteAnimationComponent {
  CartComponentAnimated(String imagePath, Vector2 position)
      : super.fromFrameData(
            Flame.images.fromCache(imagePath),
            SpriteAnimationData.sequenced(
              textureSize: Vector2(300, 256),
              amount: 4,
              amountPerRow: 4,
              stepTime: 0.1,
            ),
            size: Vector2(225, 192),
            position: position);
}

/// Big cart component
///
/// This component assume that their respective images are loaded
class BigCartComponent extends SpriteAnimationComponent {
  BigCartComponent(String cartKey, Vector2 position)
      : super.fromFrameData(
            Flame.images.fromCache("items/$cartKey.png"),
            SpriteAnimationData.sequenced(
              textureSize: Vector2(300, 128),
              amount: 4,
              amountPerRow: 4,
              stepTime: 0.3,
            ),
            size: Vector2(450, 196),
            position: position);
}

/// Human animated component
///
/// This component assume that their respective images are loaded
class HumanComponentAnimated extends SpriteAnimationComponent {
  HumanComponentAnimated(String humanKey, Vector2 position)
      : super.fromFrameData(
          Flame.images.fromCache("characters/$humanKey-animation.png"),
          SpriteAnimationData.sequenced(
            textureSize: Vector2(64, 64),
            amount: 6,
            amountPerRow: 6,
            stepTime: 0.2,
          ),
          size: Vector2(60, 60),
          position: position,
        );
}

/// Human component
///
/// This component assume that their respective images are loaded
class HumanComponent extends SpriteAnimationComponent {
  HumanComponent(String humanKey, Vector2 position)
      : super.fromFrameData(
          Flame.images.fromCache("characters/$humanKey.png"),
          SpriteAnimationData.sequenced(
            textureSize: Vector2(256, 256),
            amount: 1,
            amountPerRow: 1,
            stepTime: 0.5,
          ),
          size: Vector2(60, 60),
          position: position,
        );
}

/// Pet component
///
/// Various pets can be displayed through their definition in [PetAnimationDetails]
/// This component assume that their respective images are loaded
class PetComponent extends SpriteAnimationComponent {
  PetComponent(String petKey)
      : super.fromFrameData(
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
