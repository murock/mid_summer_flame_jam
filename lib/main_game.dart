import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';
import 'package:wildlife_garden_simulator/sprite_components/player.dart';

class MainGame extends FlameGame
    with MouseMovementDetector, HasCollisionDetection, HasTappables {
  late final Player player;
  late final Box box;

  @override
  Future<void>? onLoad() async {
    debugMode = true;
    camera.viewport = FixedResolutionViewport(Vector2(
      Constants.resolutionX,
      Constants.resolutionY,
    ));
    player = Player(
      position: size / 2,
      size: Vector2.all(100),
    );
    add(player);
    box = Box(
      position: size / 4,
      size: Vector2.all(100),
    );
    add(box);
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    player.onMouseMove(info);
  }
}
