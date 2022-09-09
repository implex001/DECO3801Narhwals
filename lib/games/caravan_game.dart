import 'dart:async' as dartasync;

import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/step_tracker.dart';
import 'package:caravaneering/model/items_details.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/extensions.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CaravanGame extends FlameGame with HorizontalDragDetector {
  static const String description = '''
    Caravan Game
  ''';

  late StepTracker stepTracker;
  SaveModel? save;

  List<String> equippedHorses = List.from(ItemDetails.startingHorses);
  List<String> equippedCarts = List.from(ItemDetails.startingCarts);
  List<String> equippedPets = List.from(ItemDetails.startingPets);

  Map<String,Sprite> loadedSprites = {};
  Map<String, SpriteComponent> currentActors = {};

  int backgroundSteps = 0;
  late ParallaxComponent<FlameGame> parallaxComponent;

  void renderEquipped() async {
    if (equippedHorses.isNotEmpty) {
      if (!loadedSprites.containsKey(equippedHorses[0])) {
        var horseImage = await images.load('items/${equippedHorses[0]}.png');
        loadedSprites[equippedHorses[0]] = Sprite(horseImage);
      }
      if (currentActors.containsKey(ItemDetails.horseKey)) {
        remove(currentActors[ItemDetails.horseKey]!);
      }

      currentActors[ItemDetails.horseKey] = SpriteComponent(
          sprite: loadedSprites[equippedHorses[0]],
          size: Vector2(100, 86.54),
          position: Vector2(320, 195),
      );

      add(currentActors[ItemDetails.horseKey]!);
    }

    if (equippedCarts.isNotEmpty) {
      if (!loadedSprites.containsKey(equippedCarts[0])) {
        var horseImage = await images.load('items/${equippedCarts[0]}.png');
        loadedSprites[equippedCarts[0]] = Sprite(horseImage);
      }
      if (currentActors.containsKey(ItemDetails.cartKey)) {
        remove(currentActors[ItemDetails.cartKey]!);
      }

      currentActors[ItemDetails.cartKey] = SpriteComponent(
        sprite: loadedSprites[equippedCarts[0]],
          size: Vector2(80, 106),
          position: Vector2(240, 175)
      );

      add(currentActors[ItemDetails.cartKey]!);
    }
  }

  @override
  Future<void>? onLoad() async {
    //Set orientation
    Flame.device.setLandscape();
    Flame.device.fullScreen();

    camera.speed = 2000;
    parallaxComponent = await loadParallaxComponent([
      ParallaxImageData('General/Sky.png'),
      ParallaxImageData('General/Clouds.png'),
      ParallaxImageData('General/Midground.png'),
      ParallaxImageData('General/Foreground.png'),
      ParallaxImageData('General/Details.png'),
      // General/Details.png
    ], velocityMultiplierDelta: Vector2(1.1, 0));
    add(parallaxComponent);

    renderEquipped();

    var horseLeadsImage = await images.load('General/CartToHorse.png');
    Sprite horseLeadSprite = Sprite(horseLeadsImage);
    final horseLeads = SpriteComponent(
        sprite: horseLeadSprite, size: Vector2(180, 90), position: Vector2(235, 185));

    var mainChar = await images.load('General/MainCharacterFinal.png');
    Sprite mainCharSprite = Sprite(mainChar);
    final mainCharacter = SpriteComponent(
        sprite: mainCharSprite, size: Vector2(60, 60), position: Vector2(420, 220));

    add(horseLeads);
    add(mainCharacter);
  }

  @override
  void onAttach() {
    super.onAttach();

    if (save == null) {
      // Set up save
      save = Provider.of<SaveModel>(buildContext!);
      save?.init().then((s) {
        //If first save set date to yesterday
        DateTime? lastsave = s.getLastTime();
        lastsave ??= DateTime.now().subtract(const Duration(days: 1));

        equippedHorses = List.from(s.get(SaveKeysV1.equippedHorses));
        equippedCarts = List.from(s.get(SaveKeysV1.equippedCarts));
        equippedPets = List.from(s.get(SaveKeysV1.equippedPets));
        save!.hasUpdatedEquipped = true;

        // Set up step tracking
        stepTracker = StepTracker();
        stepTracker
            .getBackgroundStepData(lastsave, DateTime.now())
            .then((steps) {
          if (steps == null) {
            return;
          }
          backgroundSteps = steps;
          if (backgroundSteps != 0) {
            overlays.add("StepUpdate");
            dartasync.Timer(const Duration(seconds: 5),
                () => overlays.remove("StepUpdate"));
            s.addCoins(backgroundSteps);
            s.saveState(force: true);
          }
        });
        stepTracker.getStepStream().listen((event) {
          s.addCoins(1);
        });
        s.startAutoSave();
      });
    }
  }

  @override
  Color backgroundColor() {
    return const Color(0xFFFFFFFF);
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    camera.translateBy(-info.delta.game * 3);
    parallaxComponent.parallax?.baseVelocity =
        Vector2(-info.delta.game.x * 100, 0);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (save != null && save!.hasUpdatedEquipped) {
      equippedHorses = List.from(save!.get(SaveKeysV1.equippedHorses));
      equippedCarts = List.from(save!.get(SaveKeysV1.equippedCarts));
      equippedPets = List.from(save!.get(SaveKeysV1.equippedPets));
      renderEquipped();
      save!.hasUpdatedEquipped = false;
    }
  }

  // Navigation Related Functions

  void navigateMiniGameOverlay() {
    overlays.add("MiniGames");
  }

  void exitMiniGameOverlay() {
    overlays.remove("MiniGames");
  }

}
