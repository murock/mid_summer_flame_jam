import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';

class Plant extends Box {
  Plant({
    required super.imagePath,
    super.position,
    required this.imagePaths,
    int currentStage = 0,
    required this.harvestValue,
    required this.spoilValue,
  }) {
    this.currentStage = currentStage;
  }

  final int harvestValue;
  final int spoilValue;

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
      harvestValue: 10,
      spoilValue: -5,
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
      harvestValue: 1,
      spoilValue: 0,
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
      harvestValue: 3,
      spoilValue: -1,
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
      harvestValue: 5,
      spoilValue: -2,
    );
  }

  final List<String> imagePaths;
  late int currentStage;

  late Timer growthTimer;

  @override
  void interact() {
    if (currentStage + 1 == imagePaths.length) {
      FlameAudio.play('pop.mp3');
      gameRef.updateScore(harvestValue);
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
          gameRef.updateScore(spoilValue);
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
