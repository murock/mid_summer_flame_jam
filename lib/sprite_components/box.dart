import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/main_game.dart';
import 'package:wildlife_garden_simulator/utils/utils.dart';

class Box extends SpriteComponent with Tappable, HasGameRef<MainGame> {
  Box({
    super.position,
    Vector2? size,
    super.priority,
    required this.imagePath,
  }) : super(
          size: size ?? Vector2.all(100),
          anchor: Anchor.center,
          paint: Paint()..color = ColorExtension.fromRGBHexString('#14F596'),
        );

  final String imagePath;

  void interact() {
    gameRef.updateScore(10);
  }

  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await Flame.images.load('static/$imagePath'));

    CircleHitbox hitbox = CircleHitbox();
    hitbox.collisionType = CollisionType.passive;

    add(hitbox);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    Vector2 boxPosition = Vector2(
      position.x + size.x / 2,
      position.y + size.y / 2,
    );
    Vector2 playerPosition = Vector2(
      gameRef.player.position.x + gameRef.player.size.x / 2,
      gameRef.player.position.y + gameRef.player.size.y / 2,
    );
    var distanceBetweenPoints =
        getDistanceBetweenPoints(boxPosition, playerPosition);

    print(distanceBetweenPoints);

    if (distanceBetweenPoints < Constants.maxInteractDistance) {
      interact();
    }

    return super.onTapUp(info);
  }
}
