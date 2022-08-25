import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/extensions.dart';


class CaravanGame extends FlameGame with HorizontalDragDetector {

  static const String description = '''
    Caravan Game
  ''';

  // Do not do what this is doing and put global variables
  // This is a placeholder to be removed
  // We would ideally have a seperate class for each type of object
  // and add each to a list to instantiate
  static const speed = 2000.0;
  final _size = Vector2.all(50);

  Vector2 position = Vector2.all(100);
  Vector2? target;

  late Sprite T1;
  late Image _image;

  @override
  Future<void>? onLoad() async{
    _image = await images.load('placeholders/T1.png');
    Sprite T1 = Sprite(_image);
    final player = SpriteComponent(
      sprite: T1,
      size: _size,
      position: Vector2(100,200)
    );
    add(player);
    camera.speed = speed;
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