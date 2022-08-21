import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/splash_screen/tutorial.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';
import 'package:wildlife_garden_simulator/sprite_components/plant.dart';
import 'package:wildlife_garden_simulator/sprite_components/play_button.dart';
import 'package:wildlife_garden_simulator/sprite_components/player.dart';

class MainGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, HasTappables {
  late final Player player;
  late final Box box;
  late TextComponent _scoreText;

  late Tutorial tutorial;
  late PlayButton _startButton;

  int score = 0;

  final Vector2 velocity = Vector2(0, 0);
  static const int speed = 300;
  bool isPlaying = false;

  late Timer gameTimer;

  void gameOver() {
    pauseEngine();
    overlays.add('GameOver');
  }

  @override
  Future<void>? onLoad() async {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('music.mp3');

    camera.viewport = FixedResolutionViewport(Vector2(
      Constants.resolutionX,
      Constants.resolutionY,
    ));

    player = Player(
      position: size / 2,
      size: Vector2.all(100),
    );

    _scoreText = TextComponent(text: score.toString());
    _scoreText.x = Constants.resolutionX / 2;
    _scoreText.y = _scoreText.height;

    gameTimer = Timer(60, onTick: gameOver);

    showIntro();
    //  SetupGame();
  }

  void showIntro() {
    tutorial = Tutorial();
    add(tutorial);
    _startButton = PlayButton();
    add(_startButton);
  }

  void SetupGame() {
    //  debugMode = true;
    isPlaying = true;
    remove(tutorial);
    add(_scoreText);

    add(player);
    // Carrots
    Plant plant1 = Plant.carrot(
      position: Vector2(500, 400),
      currentStage: 0,
    );
    Plant plant2 = Plant.carrot(
      position: Vector2(500, 500),
      currentStage: 1,
    );
    Plant plant3 = Plant.carrot(
      position: Vector2(500, 600),
      currentStage: 2,
    );
    Plant plant4 = Plant.carrot(
      position: Vector2(1600, 400),
      currentStage: 3,
    );
    Plant plant5 = Plant.carrot(
      position: Vector2(1600, 500),
      currentStage: 3,
    );
    Plant plant6 = Plant.carrot(
      position: Vector2(1600, 600),
      currentStage: 3,
    );

    add(plant1);
    add(plant2);
    add(plant3);
    add(plant4);
    add(plant5);
    add(plant6);

    // Potatos
    Plant potato1 = Plant.potato(
      position: Vector2(1000, 400),
      currentStage: 0,
    );
    Plant potato2 = Plant.potato(
      position: Vector2(1000, 500),
      currentStage: 1,
    );
    Plant potato3 = Plant.potato(
      position: Vector2(1000, 600),
      currentStage: 2,
    );
    Plant potato4 = Plant.potato(
      position: Vector2(1100, 400),
      currentStage: 3,
    );
    Plant potato5 = Plant.potato(
      position: Vector2(1100, 500),
      currentStage: 2,
    );
    Plant potato6 = Plant.potato(
      position: Vector2(1100, 600),
      currentStage: 3,
    );
    add(potato1);
    add(potato2);
    add(potato3);
    add(potato4);
    add(potato5);
    add(potato6);

    //Sunflowers
    Plant sun1 = Plant.sun(
      position: Vector2(1275, 200),
      currentStage: 0,
    );
    Plant sun2 = Plant.sun(
      position: Vector2(1375, 200),
      currentStage: 1,
    );
    Plant sun3 = Plant.sun(
      position: Vector2(1475, 200),
      currentStage: 2,
    );
    Plant sun4 = Plant.sun(
      position: Vector2(1275, 800),
      currentStage: 0,
    );
    Plant sun5 = Plant.sun(
      position: Vector2(1375, 800),
      currentStage: 1,
    );
    Plant sun6 = Plant.sun(
      position: Vector2(1475, 800),
      currentStage: 2,
    );

    add(sun1);
    add(sun2);
    add(sun3);
    add(sun4);
    add(sun5);
    add(sun6);

    // Tulips
    Plant tulip1 = Plant.tulip(
      position: Vector2(625, 200),
      currentStage: 0,
    );
    Plant tulip2 = Plant.tulip(
      position: Vector2(725, 200),
      currentStage: 1,
    );
    Plant tulip3 = Plant.tulip(
      position: Vector2(825, 200),
      currentStage: 2,
    );
    Plant tulip4 = Plant.tulip(
      position: Vector2(625, 800),
      currentStage: 0,
    );
    Plant tulip5 = Plant.tulip(
      position: Vector2(725, 800),
      currentStage: 1,
    );
    Plant tulip6 = Plant.tulip(
      position: Vector2(825, 800),
      currentStage: 2,
    );

    add(tulip1);
    add(tulip2);
    add(tulip3);
    add(tulip4);
    add(tulip5);
    add(tulip6);
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

    // final isKeyUp = event is RawKeyUpEvent;
    // if (isKeyUp) {
    //   player.current = PlayerState.idle;
    //   velocity.x = 0;
    //   velocity.y = 0;
    //   return KeyEventResult.handled;
    // }

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

    if (isPlaying) {
      gameTimer.update(dt);
    }
  }
}
