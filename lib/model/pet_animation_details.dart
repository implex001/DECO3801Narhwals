import 'package:flame/components.dart';

/// Specifications of pet animations
class PetAnimationDetails{
  static Map<String, Map<String, dynamic>> pets = {
    "cat-white": {
      "key": "cat-white",
      "spriteSize": Vector2(32,32),
      "animationCount": 4,
      "filename": "items/cat-white-animation.png",
      "position": Vector2(420, 300),
      "size": Vector2(40, 40),
      "stepTime": 0.3,
    },
    "cat-black": {
      "key": "cat-black",
      "spriteSize": Vector2(32,32),
      "animationCount": 4,
      "filename": "items/cat-black-animation.png",
      "position": Vector2(120, 280),
      "size": Vector2(40, 40),
      "stepTime": 0.3,
    },
    "cat-orange": {
      "key": "cat-orange",
      "spriteSize": Vector2(32,32),
      "animationCount": 4,
      "filename": "items/cat-orange-animation.png",
      "position": Vector2(270, 280),
      "size": Vector2(40, 40),
      "stepTime": 0.3,
    },
    "dog-brown": {
      "key": "dog-brown",
      "spriteSize": Vector2(32,32),
      "animationCount": 4,
      "filename": "items/dog-brown-animation.png",
      "position": Vector2(320, 280),
      "size": Vector2(80, 80),
      "stepTime": 0.3,
    },
    "dog-yellow": {
      "key": "dog-yellow",
      "spriteSize": Vector2(32,32),
      "animationCount": 4,
      "filename": "items/dog-yellow-animation.png",
      "position": Vector2(200, 280),
      "size": Vector2(80, 80),
      "stepTime": 0.3,
    },
    "dog-white": {
      "key": "dog-white",
      "spriteSize": Vector2(32,32),
      "animationCount": 4,
      "filename": "items/dog-white-animation.png",
      "position": Vector2(170, 250),
      "size": Vector2(60, 60),
      "stepTime": 0.3,
    },
    "bird-pink": {
      "key": "bird-pink",
      "spriteSize": Vector2(32,32),
      "animationCount": 10,
      "filename": "items/bird-pink-animation.png",
      "position": Vector2(280, 60),
      "size": Vector2(60, 60),
      "stepTime": 0.1,
    },
    "bird-blue": {
      "key": "bird-blue",
      "spriteSize": Vector2(32,32),
      "animationCount": 10,
      "filename": "items/bird-blue-animation.png",
      "position": Vector2(390, 80),
      "size": Vector2(60, 60),
      "stepTime": 0.12,
    },
    "dragon": {
      "key": "dragon",
      "spriteSize": Vector2(64,64),
      "animationCount": 10,
      "filename": "items/dragon-animation.png",
      "position": Vector2(140, 40),
      "size": Vector2(100, 100),
      "stepTime": 0.1,
    }
  };
}