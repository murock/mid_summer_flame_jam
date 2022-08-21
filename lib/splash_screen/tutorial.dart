import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:wildlife_garden_simulator/constants.dart';

class Tutorial extends SpriteComponent {
  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await Flame.images.load('static/splash_screen.png'));
    size = Vector2(Constants.resolutionX, Constants.resolutionY);
    return super.onLoad();
  }
}
