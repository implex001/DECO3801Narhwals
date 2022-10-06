import 'dart:ui';
import 'package:caravaneering/views/story_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/story.dart' as story;
import 'package:caravaneering/stories/story_definitions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:provider/provider.dart';

class WorldGame extends FlameGame
    with HorizontalDragDetector, HasTappableComponents {
  // Hard coded world for test
  story.World world = WorldFactory.createWorld('W1');
  Vector2 cameraPosition = Vector2.zero();
  SaveModel? save;
  late double ratio;
  late double worldBound;
  Function(story.Episode) selectedEpisodeCallback;
  List<Dot> dots = [];

  WorldGame(this.selectedEpisodeCallback);

  @override
  Future<void> onLoad() async {
    camera.followVector2(
      cameraPosition,
      relativeOffset: Anchor.topLeft,
    );
    camera.speed = 100;

    Sprite backgroundImage = await loadSprite(world.backgroundImagePath);
    ratio = backgroundImage.originalSize.y / camera.viewport.effectiveSize.y;

    SpriteComponent backgroundComponent = SpriteComponent(
      sprite: backgroundImage,
      size: Vector2(backgroundImage.originalSize.x / ratio,
          camera.viewport.effectiveSize.y),
    );

    add(backgroundComponent);

    worldBound = backgroundComponent.size.x - camera.viewport.effectiveSize.x;
  }

  @override
  void onAttach() {
    super.onAttach();
    if (save == null) {
      save = Provider.of<SaveModel>(buildContext!);
      List<dynamic> unlocked = save!.get(SaveKeysV1.unlockedEpisodes);

      // Add episodes
      for (story.Episode episode in world.episodes) {
        // Check progression
        if (save!.get(SaveKeysV1.lifeTimeSteps) > episode.requiredSteps &&
            !unlocked.contains(episode.id)) {
          save!.addUnlockedEpisode(episode.id);
          unlocked.add(episode.id);
        }
        save!.save.save();

        Dot dot = Dot<story.Episode>(
            Vector2(episode.position.x / ratio, episode.position.y / ratio),
                (e) {
              for (Dot d in dots) {
                d.hideSelected();
              }
              selectedEpisodeCallback(e);
            }, episode);
        if (unlocked.contains(episode.id)) {
          dot.unlocked = true;
          dot.showUnlocked();
        }
        dots.add(dot);
        add(dot);
      }
    }
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    if (cameraPosition.x - info.delta.global.x < worldBound &&
        cameraPosition.x - info.delta.global.x > 0) {
      cameraPosition.add(Vector2(-info.delta.global.x, 0));
    }
  }

  void playEpisode(story.Episode episode) {
    episode.reset();
    save!.changeBiome(episode.biomeType);
    Navigator.push(
        buildContext!,
        MaterialPageRoute(
            builder: (context) =>
                EpisodeView(
                    episode: episode,
                    onEnd: () => Navigator.pop(buildContext!))));
  }
}

class Dot<T> extends CircleComponent with TapCallbacks {
  final Function(T) onTap;
  final T data;
  bool unlocked = false;
  bool selected = false;

  Dot(Vector2 position, this.onTap, this.data)
      : super(radius: 10,
      position: position,
      anchor: Anchor.center,
      paint: Paint()..color = const Color(0x80FFFFFF));

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    if (!selected) {
      onTap(data);
      showSelected();
    }
  }

  void showSelected() {
    super.radius = 10;
    if (unlocked) {
      super.paint.color = Colors.green;
    } else {
      super.paint.color = Colors.white;
    }

    selected = true;
  }

  void hideSelected() {
    super.radius = 10;

    if (unlocked) {
      super.paint.color = Colors.lightGreen;
    } else {
      super.paint.color = const Color(0x80FFFFFF);
    }
    selected = false;
  }

  void showUnlocked() {
    if (unlocked) {
      super.paint.color = Colors.green;
    }
  }
}

class DisabledDot extends CircleComponent {
  DisabledDot(Vector2 position)
      : super(
      radius: 5,
      position: position,
      paint: Paint()
        ..color = const Color(0x80FFFFFF),
      anchor: Anchor.center);
}
