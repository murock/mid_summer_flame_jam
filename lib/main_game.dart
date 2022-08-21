import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flame/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mini_sprite/mini_sprite.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';
import 'package:wildlife_garden_simulator/sprite_components/plant.dart';
import 'package:wildlife_garden_simulator/sprite_components/player.dart';

class MainGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, HasTappables {
  late final Player player;
  late final Box box;
  late TextComponent _scoreText;

  int score = 0;

  final Vector2 velocity = Vector2(0, 0);
  static const int speed = 300;

  @override
  Future<void>? onLoad() async {
    camera.viewport = FixedResolutionViewport(Vector2(
      Constants.resolutionX,
      Constants.resolutionY,
    ));

    _scoreText = TextComponent(text: score.toString());
    _scoreText.x = Constants.resolutionX / 2;
    _scoreText.y = _scoreText.height;
    add(_scoreText);

    player = Player(
      position: size / 2,
      size: Vector2.all(100),
    );
    add(player);
    // Carrots
    Plant plant1 = Plant.carrot(
      position: Vector2(100, 50),
      currentStage: 0,
    );
    Plant plant2 = Plant.carrot(
      position: Vector2(200, 50),
      currentStage: 1,
    );
    Plant plant3 = Plant.carrot(
      position: Vector2(300, 50),
      currentStage: 2,
    );
    Plant plant4 = Plant.carrot(
      position: Vector2(400, 50),
      currentStage: 3,
    );

    add(plant1);
    add(plant2);
    add(plant3);
    add(plant4);

    // Potatos
    Plant potato1 = Plant.potato(
      position: Vector2(100, 450),
      currentStage: 0,
    );
    Plant potato2 = Plant.potato(
      position: Vector2(200, 450),
      currentStage: 1,
    );
    Plant potato3 = Plant.potato(
      position: Vector2(300, 450),
      currentStage: 2,
    );
    Plant potato4 = Plant.potato(
      position: Vector2(400, 450),
      currentStage: 3,
    );
    add(potato1);
    add(potato2);
    add(potato3);
    add(potato4);

    //Sunflowers
    Plant sun1 = Plant.sun(
      position: Vector2(1500, 250),
      currentStage: 0,
    );
    Plant sun2 = Plant.sun(
      position: Vector2(1200, 250),
      currentStage: 1,
    );
    Plant sun3 = Plant.sun(
      position: Vector2(1300, 250),
      currentStage: 2,
    );
    Plant sun4 = Plant.sun(
      position: Vector2(1400, 250),
      currentStage: 3,
    );
    add(sun1);
    add(sun2);
    add(sun3);
    add(sun4);

    // Tulips
    Plant tulip1 = Plant.tulip(
      position: Vector2(1500, 450),
      currentStage: 0,
    );
    Plant tulip2 = Plant.tulip(
      position: Vector2(1200, 450),
      currentStage: 1,
    );
    Plant tulip3 = Plant.tulip(
      position: Vector2(1300, 450),
      currentStage: 2,
    );
    Plant tulip4 = Plant.tulip(
      position: Vector2(1400, 450),
      currentStage: 3,
    );
    add(tulip1);
    add(tulip2);
    add(tulip3);
    add(tulip4);
  }

  void updateScore(int amount) {
    score += amount;
    _scoreText.text = score.toString();
  }

  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isKeyUp = event is RawKeyUpEvent;
    if (isKeyUp) {
      player.current = PlayerState.idle;
      velocity.x = 0;
      velocity.y = 0;
      return KeyEventResult.handled;
    }

    //Movement
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      player.current = PlayerState.left;
      player.faceLeft();
      velocity.x = isKeyDown ? -1 : 0;
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      player.current = PlayerState.right;
      player.faceRight();
      velocity.x = isKeyDown ? 1 : 0;
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      player.current = PlayerState.up;
      velocity.y = isKeyDown ? -1 : 0;
      return KeyEventResult.handled;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      player.current = PlayerState.down;
      velocity.y = isKeyDown ? 1 : 0;
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final displacement = velocity * (speed * dt);
    player.position.add(displacement);
  }
}
