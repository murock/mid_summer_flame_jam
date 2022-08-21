import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/main_game.dart';

enum ButtonState { pressed, unpressed }

class PlayButton extends SpriteGroupComponent<ButtonState>
    with HasGameRef<MainGame>, Tappable {
  @override
  Future<void>? onLoad() async {
    size = Vector2(500, 100);
    position = Vector2((Constants.resolutionX / 2) - size.x / 2,
        Constants.resolutionY - size.y);
    final pressedSprite = await gameRef.loadSprite('static/pressed.png');
    final unpressedSprite = await gameRef.loadSprite('static/unpressed.png');

    sprites = {
      ButtonState.pressed: pressedSprite,
      ButtonState.unpressed: unpressedSprite,
    };

    current = ButtonState.unpressed;
  }

  void startGame() {
    gameRef.SetupGame();
    removeFromParent();
  }

  @override
  bool onTapUp(TapUpInfo info) {
    if (current == ButtonState.unpressed) {
      current = ButtonState.pressed;
      startGame();
    }

    return super.onTapUp(info);
  }
}
