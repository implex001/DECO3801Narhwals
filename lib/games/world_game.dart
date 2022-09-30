import 'package:caravaneering/model/story.dart';
import 'package:caravaneering/stories/story_definitions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class WorldGame extends FlameGame {

  // Hard coded world for test
  World world = WorldFactory.createWorld('W1');

  @override
  Future<void> onLoad() async {
    Sprite backgroundImage = await loadSprite(world.backgroundImagePath);
    SpriteComponent backgroundComponent = SpriteComponent(
      sprite: backgroundImage,
    );


    add(backgroundComponent);
  }
}