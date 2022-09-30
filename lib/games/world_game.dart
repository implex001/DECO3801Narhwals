import 'dart:ui';

import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/story.dart' as story;
import 'package:caravaneering/stories/story_definitions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:provider/provider.dart';

class WorldGame extends FlameGame with HorizontalDragDetector, HasTappableComponents{

  // Hard coded world for test
  story.World world = WorldFactory.createWorld('W1');
  Vector2 cameraPosition = Vector2.zero();
  SaveModel? save;
  late double ratio;

  @override
  Future<void> onLoad() async {
    camera.followVector2(
      cameraPosition,
      relativeOffset: Anchor.topLeft,
    );
    camera.speed = 100;

    Sprite backgroundImage = await loadSprite(world.backgroundImagePath);
    ratio = backgroundImage.originalSize.y /
        camera.viewport.effectiveSize.y;

    SpriteComponent backgroundComponent = SpriteComponent(
      sprite: backgroundImage,
      size: Vector2(backgroundImage.originalSize.x / ratio,
          camera.viewport.effectiveSize.y),
    );

    add(backgroundComponent);


  }

  @override
  void onAttach() {
    super.onAttach();
    if (save == null) {
      save = Provider.of<SaveModel>(buildContext!);
      List<dynamic> unlocked = save?.get(SaveKeysV1.unlockedEpisodes);
      // Add episodes
      for (story.Episode episode in world.episodes) {
        CircleComponent dot;
        if (unlocked.contains(episode.id)) {
          dot = EpisodeDot(Vector2(episode.position.x / ratio, episode.position.y / ratio), () {});
        } else {
          dot = DisabledEpisodeDot(Vector2(episode.position.x / ratio, episode.position.y / ratio));
        }

        add(dot);
      }
    }
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    cameraPosition.add(Vector2(-info.delta.global.x, 0));
  }
}

class EpisodeDot extends CircleComponent with TapCallbacks{
  final VoidCallback onTap;

  EpisodeDot(Vector2 position, this.onTap) :
        super(radius: 10, position: position, anchor: Anchor.center);

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onTap();
  }
}

class DisabledEpisodeDot extends CircleComponent{

  DisabledEpisodeDot(Vector2 position) :
        super(radius: 5,
          position: position,
          paint: Paint()..color = const Color(0x80FFFFFF),
          anchor: Anchor.center);
}