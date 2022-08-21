import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';

class Plant extends Box {
  Plant({
    required super.imagePath,
    super.position,
    required this.imagePaths,
    int currentStage = 0,
  }) {
    this.currentStage = currentStage;
  }

  factory Plant.carrot({
    required Vector2 position,
    int currentStage = 0,
  }) {
    return Plant(
      imagePath: 'carrot1.png',
      imagePaths: [
        'carrot1.png',
        'carrot2.png',
        'carrot3.png',
        'carrot4.png',
      ],
      position: position,
      currentStage: currentStage,
    );
  }

  factory Plant.potato({
    required Vector2 position,
    int currentStage = 0,
  }) {
    return Plant(
      imagePath: 'potato1.png',
      imagePaths: [
        'potato1.png',
        'potato2.png',
        'potato3.png',
        'potato4.png',
      ],
      position: position,
      currentStage: currentStage,
    );
  }

  factory Plant.sun({
    required Vector2 position,
    int currentStage = 0,
  }) {
    return Plant(
      imagePath: 'sun1.png',
      imagePaths: [
        'sun1.png',
        'sun2.png',
        'sun3.png',
        'sun4.png',
      ],
      position: position,
      currentStage: currentStage,
    );
  }

  factory Plant.tulip({
    required Vector2 position,
    int currentStage = 0,
  }) {
    return Plant(
      imagePath: 'tulip1.png',
      imagePaths: [
        'tulip1.png',
        'tulip2.png',
        'tulip3.png',
        'tulip4.png',
      ],
      position: position,
      currentStage: currentStage,
    );
  }

  final List<String> imagePaths;
  late int currentStage;

  late Timer growthTimer;

  @override
  void interact() {
    if (currentStage + 1 == imagePaths.length) {
      gameRef.updateScore(10);
      currentStage = 0;
      setSprite();
      growthTimer.reset();
    }
  }

  void setSprite() async {
    sprite =
        Sprite(await Flame.images.load('static/${imagePaths[currentStage]}'));
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    setSprite();
    Random random = new Random();
    double growthRate = random.nextInt(6) + 5;
    growthTimer = Timer(
      growthRate,
      onTick: () async {
        if (currentStage + 1 < imagePaths.length) {
          // more stages left
          currentStage++;
        } else {
          currentStage = 0;
        }
        sprite = Sprite(
            await Flame.images.load('static/${imagePaths[currentStage]}'));
      },
      repeat: true,
    );
  }

  @override
  void update(double dt) {
    growthTimer.update(dt);
    // if(growthTimer.)
    super.update(dt);
  }
}
