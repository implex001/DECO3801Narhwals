import 'dart:async';

import 'package:caravaneering/model/save_model.dart';
import 'package:caravaneering/model/step_tracker.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class CaravanGame extends FlameGame with HorizontalDragDetector {

  static const String description = '''
    Caravan Game
  ''';

  late StepTracker stepTracker;
  SaveModel? save;

  int backgroundSteps = 0;

  @override
  Future<void>? onLoad() async{

    //Set orientation
    Flame.device.setLandscape();
    Flame.device.fullScreen();

    camera.speed = 2000;

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

        // Set up step tracking
        stepTracker = StepTracker();
        stepTracker.getBackgroundStepData(
            lastsave, DateTime.now()).then(
                (steps) {
                  if (steps == null) {
                    return;
                  }
                  backgroundSteps = steps;
                  if (backgroundSteps != 0) {
                    overlays.add("StepUpdate");
                    Timer(
                        const Duration(seconds: 5),
                            () => overlays.remove("StepUpdate"));
                    s.addCoins(backgroundSteps);
                    s.saveState(force: true);
                  }
            }
        );
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
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}