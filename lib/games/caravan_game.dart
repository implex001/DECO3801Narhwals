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
        position: Vector2(240, 175),
      );

      add(currentActors[ItemDetails.cartKey]!);
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

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
    if (cameraPosition.x - info.delta.global.x < worldBound &&
        cameraPosition.x - info.delta.global.x > -worldBound) {
      cameraPosition.add(Vector2(-info.delta.global.x, 0));
    }
  }
}
