import 'dart:async' as dartasync;

import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/step_tracker.dart';
import 'package:caravaneering/model/items_details.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/extensions.dart';
import 'package:flame/parallax.dart';
import 'package:provider/provider.dart';


class CaravanGame extends FlameGame with
    VerticalDragDetector,
    MultiTouchDragDetector,
    MultiTouchTapDetector {

  static const String description = '''
    Caravan Game
  ''';
  late StepTracker stepTracker;
  SaveModel? save;

  static final parralaxBgVelocityIncrease = Vector2(3.0, 0);
  static const framesPerSecond = 60.0;
  static const deltaThresholdToUpdateParralax = 0.005;
  Vector2 lastCameraPosition = Vector2.zero();
  Vector2 cameraPosition = Vector2.zero();
  int worldBound = 300;

  bool placeholderEquips = true;
  bool petEquipped = false;
  List<String> equippedHorses = List.from(ItemDetails.startingHorses);
  List<String> equippedCarts = List.from(ItemDetails.startingCarts);
  List<String> equippedPets = List.from(ItemDetails.startingPets);

  Map<String, Image> loadedImages = {};
  Map<String, SpriteAnimationComponent> currentActors = {};

  int backgroundSteps = 0;
  late ParallaxComponent<FlameGame> parallaxComponent;

  Map<String, Map<String, dynamic>> pets = {
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

  void renderEquipped() async {
    if (equippedHorses.isNotEmpty) {
      if (!loadedImages.containsKey(equippedHorses[0])) {
        loadedImages[equippedHorses[0]] = await images.load("items/${equippedHorses[0]}-animation.png");
      }
      if (currentActors.containsKey(ItemDetails.horseKey)) {
        remove(currentActors[ItemDetails.horseKey]!);
      }

      final horseSpriteSize = Vector2(260,225);
      final horseSpriteData = SpriteAnimationData.sequenced(
        textureSize: horseSpriteSize,
        amount: 4,
        amountPerRow: 2,
        stepTime: 0.2,
      );
      currentActors[ItemDetails.horseKey] = SpriteAnimationComponent.fromFrameData(
        loadedImages[equippedHorses[0]]!,
        horseSpriteData,
        size: Vector2(100, 86.54),
        position: Vector2(320, 195),
      );

      add(currentActors[ItemDetails.horseKey]!);
    }

    if (equippedCarts.isNotEmpty) {
      if (!loadedImages.containsKey(equippedCarts[0])) {
        loadedImages[equippedCarts[0]] = await images.load("items/${equippedCarts[0]}.png");
      }
      if (currentActors.containsKey(ItemDetails.cartKey)) {
        remove(currentActors[ItemDetails.cartKey]!);
      }

      final cartSpriteSize = Vector2(242,256);
      final cartSpriteData = SpriteAnimationData.sequenced(
        textureSize: cartSpriteSize,
        amount: 1,
        amountPerRow: 1,
        stepTime: 0.2,
      );
      currentActors[ItemDetails.cartKey] = SpriteAnimationComponent.fromFrameData(
          loadedImages[equippedCarts[0]]!,
          cartSpriteData,
          size: Vector2(80, 106),
          position: Vector2(240, 175)
      );

      add(currentActors[ItemDetails.cartKey]!);

    }

    // add all equipped pets to the screen
    if (equippedPets.isNotEmpty) {
      for (String pet in equippedPets) {
        // If the pet is current displayed on screen then skip
        if (currentActors.containsKey(pet)) {
          continue;
        }
        Map<String, dynamic> petDetails = pets[pet]!;
        final petSpriteSize = petDetails["spriteSize"];
        final petSpriteData = SpriteAnimationData.sequenced(
          textureSize: petSpriteSize,
          amount: petDetails["animationCount"],
          amountPerRow: petDetails["animationCount"],
          stepTime: petDetails["stepTime"],
        );
        currentActors[petDetails["key"]] = SpriteAnimationComponent.fromFrameData(
            await images.load(petDetails["filename"]),
            petSpriteData,
            size: petDetails["size"],
            position: petDetails["position"]
        );
        petEquipped = true;
        add(currentActors[petDetails["key"]]!);
      }
    }

    // If data has been reset, remove all equipped pets
    if (petEquipped && equippedPets.isEmpty) {
      for (Map<String, dynamic> pet in pets.values) {
        if (currentActors.containsKey(pet["key"])) {
          remove(currentActors[pet["key"]]!);
          currentActors.remove(pet["key"]);
        }
      }
    }
  }

  @override
  Future<void>? onLoad() async {
    //Set orientation
    Flame.device.setLandscape();
    Flame.device.fullScreen();

    camera.followVector2(
      cameraPosition,
      relativeOffset: Anchor.topLeft,
    );
    camera.speed = 100;

    final skyLayer = await loadParallaxLayer(
      ParallaxImageData('General/Sky.png'),
      velocityMultiplier: Vector2(0, 0),
    );
    final cloudsFarLayer = await loadParallaxLayer(
      ParallaxImageData('General/Clouds.png'),
      velocityMultiplier: Vector2(1.8, 0),
    );
    final midgroundLayer = await loadParallaxLayer(
      ParallaxImageData('General/Midground.png'),
      velocityMultiplier: Vector2(3.8, 0),
    );
    final foregroundLayer = await loadParallaxLayer(
      ParallaxImageData('General/Foreground.png'),
      velocityMultiplier: Vector2(20, 0),
    );
    final detailsLayer = await loadParallaxLayer(
      ParallaxImageData('General/Details.png'),
      velocityMultiplier: Vector2(20, 0),
    );
    final parallax = Parallax(
      [
        skyLayer,
        cloudsFarLayer,
        midgroundLayer,
        foregroundLayer,
        detailsLayer,
      ],
      baseVelocity: Vector2(20, 0),
    );
    parallaxComponent = ParallaxComponent(parallax: parallax);
    add(parallaxComponent);

    renderEquipped();

    var horseLeadsImage = await images.load('General/CartToHorse.png');
    Sprite horseLeadSprite = Sprite(horseLeadsImage);
    final horseLeads = SpriteComponent(
        sprite: horseLeadSprite, size: Vector2(180, 90), position: Vector2(235, 185));

    final charSpriteSize = Vector2(192,192);
    final charSpriteData = SpriteAnimationData.sequenced(
      textureSize: charSpriteSize,
      amount: 2,
      amountPerRow: 2,
      stepTime: 0.5,
    );
    final mainCharacter = SpriteAnimationComponent.fromFrameData(
        await images.load("General/MainCharacterFinal-animation.png"),
        charSpriteData,
        size: Vector2(60, 60),
        position: Vector2(420, 220)
    );

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
        int modifier = s.get("personalUpgrades");

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
            s.addCoins(backgroundSteps * modifier);
            s.saveState(force: true);
          }
        });
        stepTracker.getStepStream().listen((event) {
          s.addCoins(1 * modifier);
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
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Code below is modified from https://stackoverflow.com/questions/71131480/flutter-flame-how-to-use-parallax-with-camera-followcomponent
    final currentCameraPosition = camera.position;
    final delta = dt > deltaThresholdToUpdateParralax ? 1.0 / (dt * framesPerSecond) : 1.0;
    final baseVelocity = currentCameraPosition
      ..sub(lastCameraPosition)
      ..multiply(parralaxBgVelocityIncrease)
      ..multiply(Vector2(delta, delta));
    parallaxComponent.parallax?.baseVelocity.setFrom(baseVelocity + Vector2(2, 2));
    lastCameraPosition.setFrom(camera.position);

    if (save != null && (save!.hasUpdatedEquipped || placeholderEquips)) {
      equippedHorses = List.from(save!.get(SaveKeysV1.equippedHorses));
      equippedCarts = List.from(save!.get(SaveKeysV1.equippedCarts));
      equippedPets = List.from(save!.get(SaveKeysV1.equippedPets));
      renderEquipped();
      save!.hasUpdatedEquipped = false;
      placeholderEquips = false;
    }
  }

  // Navigation Related Functions
  void navigateMiniGameOverlay() {
    overlays.add("MiniGames");
  }

  void exitMiniGameOverlay() {
    overlays.remove("MiniGames");
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
    if (cameraPosition.x - info.delta.global.x < worldBound &&
        cameraPosition.x - info.delta.global.x > -worldBound) {
      cameraPosition.add(Vector2(-info.delta.global.x, 0));
    }
  }
}
