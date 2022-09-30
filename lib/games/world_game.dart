import 'package:caravaneering/model/story.dart';
import 'package:caravaneering/stories/story_definitions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class WorldGame extends FlameGame with HorizontalDragDetector{

  // Hard coded world for test
  World world = WorldFactory.createWorld('W1');
  Vector2 cameraPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    camera.followVector2(
      cameraPosition,
      relativeOffset: Anchor.topLeft,
    );
    camera.speed = 100;

    Sprite backgroundImage = await loadSprite(world.backgroundImagePath);
    final ratio = backgroundImage.originalSize.y /
        camera.viewport.effectiveSize.y;

    SpriteComponent backgroundComponent = SpriteComponent(
      sprite: backgroundImage,
      size: Vector2(backgroundImage.originalSize.x / ratio,
          camera.viewport.effectiveSize.y),
    );

    add(backgroundComponent);

    // Add episodes
    for (Episode episode in world.episodes) {
      CircleComponent circleComponent = CircleComponent(
        radius: 10,
        position: Vector2(episode.position.x / ratio, episode.position.y / ratio),
      );
      add(circleComponent);
    }
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    cameraPosition.add(Vector2(-info.delta.global.x, 0));
  }
}