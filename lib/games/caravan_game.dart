import 'dart:async' as dartasync;
import 'dart:io';
import 'dart:math';

import 'package:caravaneering/games/caravan_drawables.dart';
import 'package:caravaneering/model/save_keys.dart';
import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/shop/shop_items.dart';
import 'package:caravaneering/model/step_tracker.dart';
import 'package:caravaneering/model/items_details.dart';
import 'package:caravaneering/model/skills.dart';
import 'package:caravaneering/model/story.dart';
import 'package:caravaneering/views/coin_collect_animation.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/extensions.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaravanGame extends FlameGame
    with VerticalDragDetector, MultiTouchDragDetector, MultiTouchTapDetector {
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
  int worldBound = 350;

  List<String> equippedHorses = List.from(ItemDetails.startingHorses);
  List<String> equippedCarts = List.from(ItemDetails.startingCarts);
  List<String> equippedPets = List.from(ItemDetails.startingPets);
  List<Map<String, dynamic>>? allOwnedHorses = [];
  List<Map<String, dynamic>>? allOwnedCarts = [];
  List<Component> currentActors = [];

  int backgroundSteps = 0;
  ParallaxComponent<FlameGame>? parallaxComponent;
  late CoinCollectAnimation coinCollectAnimation;
  ValueNotifier<bool> coinAnimationPlaying = ValueNotifier(false);

  // Coordinates of horse and cart
  Vector2 horseCoords = Vector2(0, 0);
  Vector2 cartCoords = Vector2(0, 0);
  // Current horse index in allHorsesOwned, for item selection
  int horseOwnedIndex = 0;
  int cartOwnedIndex = 0;

  void renderEquipped() async {
    if (currentActors.isNotEmpty) {
      // Changed this from removalAll, because it gave me an error
      // saying cannot remove if not child of parent - Nhu
      currentActors.forEach((actor) {
        actor.removeFromParent();
      });
      currentActors.clear();
    }

    double parallaxRatio = 1080 / camera.viewport.effectiveSize.y;
    double xPosition = 700;

    // add all equipped pets to the screen
    if (equippedPets.isNotEmpty) {
      for (String pet in equippedPets) {
        await images.load("items/$pet-animation.png");
        var petComponent = PetComponent(pet);
        petComponent.position.x += xPosition;
        petComponent.position.y += parallaxRatio * 10;

        currentActors.add(petComponent);
      }
    }

    // Main Character
    await images.load("characters/MainCharacterFinal-animation.png");
    var mainCharacter = HumanComponentAnimated("MainCharacterFinal",
        Vector2(xPosition, parallaxRatio * 100 + Random().nextDouble()));
    currentActors.add(mainCharacter);

    xPosition -= 50 + Random().nextDouble();
    // Dungeoneer
    await images.load("characters/Dungeoneer-animation.png");
    var dungeoneer = HumanComponentAnimated("Dungeoneer",
        Vector2(xPosition, parallaxRatio * 100 + Random().nextDouble() * 5));
    currentActors.add(dungeoneer);

    xPosition -= 50 + Random().nextDouble();
    // Merchant
    await images.load("characters/Merchant-animation.png");
    var merchant = HumanComponentAnimated("Merchant",
        Vector2(xPosition, parallaxRatio * 100 + Random().nextDouble() * 5));
    currentActors.add(merchant);

    xPosition -= 200 + Random().nextDouble() * 5;
    // Horse
    horseCoords = Vector2(xPosition, parallaxRatio * 90);
    await images.load("items/${equippedHorses[0]}-animation.png");
    var horseComponent = HorseComponent(equippedHorses[0], horseCoords);
    currentActors.add(horseComponent);

    //Cart
    await images.load("items/${equippedCarts[0]}.png");
    cartCoords = Vector2(xPosition, parallaxRatio * 90);
    var cartComponent = CartComponent(equippedCarts[0], cartCoords);
    currentActors.add(cartComponent);

    // Horse Lead
    var horseLeadsImage = await images.load('General/CartToHorse.png');
    Sprite horseLeadSprite = Sprite(horseLeadsImage);
    var horseLeads = SpriteComponent(
        sprite: horseLeadSprite,
        size: Vector2(180, 90),
        position: Vector2(xPosition, parallaxRatio * 90));
    currentActors.add(horseLeads);

    xPosition -= 60;

    List<DonkeyComponent> donkeyComponents = [];

    // Misc group step upgrades
    for (int i = 1; i <= save!.get(SaveKeysV1.groupUpgrades); i++) {
      int j = i % Skill.groupUpgradeImage.length;

      if (j == 0) {
        xPosition -= 60 + Random().nextDouble();
        await images.load("items/${Skill.groupUpgradeImage[4]}-animation.png");
        var donkeyComponent = DonkeyComponent(Skill.groupUpgradeImage[4]!,
            Vector2(xPosition, parallaxRatio * 95 + Random().nextDouble()));
        donkeyComponents.add(donkeyComponent);
        continue;
      }

      xPosition -= 30 + Random().nextDouble();
      await images
          .load("characters/${Skill.groupUpgradeImage[j]}-animation.png");
      var human = HumanComponentAnimated(Skill.groupUpgradeImage[j]!,
          Vector2(xPosition, parallaxRatio * 100 + Random().nextDouble() * 5));
      currentActors.add(human);
    }
    currentActors.addAll(donkeyComponents);

    // Merchant cart
    await images.load("items/MerchantCaravan_animation.png");
    var merchantCart = BigCartComponent("MerchantCaravan_animation",
        Vector2(xPosition - 450, parallaxRatio * 55));
    currentActors.add(merchantCart);

    addAll(currentActors);
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
  }

  @override
  void onTapDown(int pointerId, TapDownInfo info) {
    super.onTapDown(pointerId, info);
    Vector2 tappedCoords = info.eventPosition.game;
    // The numbers are from caravan_drawables.dart
    if (horseCoords.x < tappedCoords.x &&
        tappedCoords.x < (horseCoords.x + 225) &&
        horseCoords.y < tappedCoords.y &&
        tappedCoords.y < (horseCoords.y + 96)) {
      horseOwnedIndex = (horseOwnedIndex + 1) % allOwnedHorses!.length;
      save?.equipHorse(1, allOwnedHorses![horseOwnedIndex]["key"]);
    }

    if (cartCoords.x < tappedCoords.x &&
        tappedCoords.x < (cartCoords.x + 80) &&
        cartCoords.y < tappedCoords.y &&
        tappedCoords.y < (cartCoords.y + 106)) {
      cartOwnedIndex = (cartOwnedIndex + 1) % allOwnedCarts!.length;
      save?.equipCart(1, allOwnedCarts![cartOwnedIndex]["key"]);
    }
  }

  @override
  void onAttach() {
    super.onAttach();
    print("in attached");

    if (save == null) {
      // Set up save
      save = Provider.of<SaveModel>(buildContext!);
      save?.init().then((s) async {
        List<Map<String, dynamic>>? allHorses =
            ShopItems.shopItemsDefaults["horses"];
        print("in attached");
        print(allHorses);
        List<Map<String, dynamic>>? allCarts =
            ShopItems.shopItemsDefaults["cart"];

        // Gets all owned horses
        allHorses?.forEach((horse) {
          bool? isOwned = save?.checkIfItemOwned(horse);
          print("in onattached");
          print(horse);
          isOwned = (isOwned == null) ? false : isOwned;
          if (isOwned) {
            allOwnedHorses!.add(horse);
          }
        });

        // Gets all owned carts
        allCarts?.forEach((cart) {
          bool? isOwned = save?.checkIfItemOwned(cart);
          isOwned = (isOwned == null) ? false : isOwned;
          if (isOwned) {
            allOwnedCarts!.add(cart);
          }
        });
        //If first save set date to yesterday
        DateTime? lastsave = s.getLastTime();
        lastsave ??= DateTime.now().subtract(const Duration(days: 1));

        equippedHorses = List.from(s.get(SaveKeysV1.equippedHorses));
        equippedCarts = List.from(s.get(SaveKeysV1.equippedCarts));
        equippedPets = List.from(s.get(SaveKeysV1.equippedPets));
        save!.hasUpdatedEquipped = true;
        int modifier = s.get(SaveKeysV1.personalUpgrades);

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
            s.addSteps(backgroundSteps * modifier);
            s.saveState(force: true);

            coinCollectAnimation = CoinCollectAnimation(
              startTop: 200,
              startLeft: 200,
              startTurn: 0,
              endTop: MediaQuery.of(buildContext!).size.height / 40,
              endLeft: MediaQuery.of(buildContext!).size.width -
                  MediaQuery.of(buildContext!).size.width / 5,
              endTurn: 20,
              numCoins: 10,
              endScale: 0.05,
            );
            showCoins();
          }
        });

        // Live step tracking
        if (await stepTracker.requestPermission()) {
          stepTracker.getStepStream().listen((event) {
            s.addCoins(1 * modifier);
            s.addSteps(1);
          });
        }

        s.startAutoSave();
      });

      // Add save state changes
      save?.addListener(() async {
        if (save!.hasUpdatedEquipped) {
          save!.hasUpdatedEquipped = false;
          equippedHorses = List.from(save!.get(SaveKeysV1.equippedHorses));
          equippedCarts = List.from(save!.get(SaveKeysV1.equippedCarts));
          equippedPets = List.from(save!.get(SaveKeysV1.equippedPets));
          await renderParallax();
          renderEquipped();
        }
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
    final delta = dt > deltaThresholdToUpdateParralax
        ? 1.0 / (dt * framesPerSecond)
        : 1.0;
    final baseVelocity = currentCameraPosition
      ..sub(lastCameraPosition)
      ..multiply(parralaxBgVelocityIncrease)
      ..multiply(Vector2(delta, delta));
    parallaxComponent?.parallax?.baseVelocity
        .setFrom(baseVelocity + Vector2(2, 2));
    lastCameraPosition.setFrom(camera.position);
  }

  void showCoins() {
    overlays.add("Coins");
    dartasync.Timer(const Duration(seconds: 5), () => overlays.remove("Coins"));
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo info) {
    if (cameraPosition.x - info.delta.global.x < worldBound &&
        cameraPosition.x - info.delta.global.x > -worldBound) {
      cameraPosition.add(Vector2(-info.delta.global.x, 0));
    }
  }

  Future<void> renderParallax() async {
    if (parallaxComponent != null) {
      remove(parallaxComponent!);
    }

    if (save!.get(SaveKeysV1.currentBiome) == BiomeType.mountain.name) {
      parallaxComponent = await createSnowBiome();
    } else {
      parallaxComponent = await createForestBiome();
    }
    add(parallaxComponent!);
  }

  Future<ParallaxComponent<FlameGame>> createForestBiome() async {
    final skyLayer = await loadParallaxLayer(
      ParallaxImageData('General/ForestSky.png'),
      velocityMultiplier: Vector2(0, 0),
    );
    final cloudsFarLayer = await loadParallaxLayer(
      ParallaxImageData('General/ForestClouds.png'),
      velocityMultiplier: Vector2(1.8, 0),
    );
    final midgroundLayer = await loadParallaxLayer(
      ParallaxImageData('General/ForestMidground.png'),
      velocityMultiplier: Vector2(3.8, 0),
    );
    final foregroundLayer = await loadParallaxLayer(
      ParallaxImageData('General/ForestForeground.png'),
      velocityMultiplier: Vector2(20, 0),
    );
    final detailsLayer = await loadParallaxLayer(
      ParallaxImageData('General/ForestDetails.png'),
      velocityMultiplier: Vector2(20, 0),
    );
    // final foregroundWithTracks = await loadParallaxLayer(
    //   ParallaxImageData('/General/ForestForeground.png'),
    //   velocityMultiplier: Vector2(20, 0),
    // );

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

    return ParallaxComponent(parallax: parallax);
  }

  Future<ParallaxComponent<FlameGame>> createSnowBiome() async {
    final skyLayer = await loadParallaxLayer(
      ParallaxImageData('General/SnowSky.png'),
      velocityMultiplier: Vector2(0, 0),
    );
    final cloudsFarLayer = await loadParallaxLayer(
      ParallaxImageData('General/SnowClouds.png'),
      velocityMultiplier: Vector2(1.8, 0),
    );
    final midgroundLayer = await loadParallaxLayer(
      ParallaxImageData('General/SnowMidground.png'),
      velocityMultiplier: Vector2(3.8, 0),
    );
    final foregroundLayer = await loadParallaxLayer(
      ParallaxImageData('General/SnowForeground.png'),
      velocityMultiplier: Vector2(20, 0),
    );
    final detailsLayer = await loadParallaxLayer(
      ParallaxImageData('General/SnowDetails.png'),
      velocityMultiplier: Vector2(20, 0),
    );
    // final foregroundWithTracks = await loadParallaxLayer(
    //   ParallaxImageData('/General/ForestForeground.png'),
    //   velocityMultiplier: Vector2(20, 0),
    // );

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

    return ParallaxComponent(parallax: parallax);
  }
}
