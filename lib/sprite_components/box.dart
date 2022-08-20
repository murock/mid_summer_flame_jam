import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Box extends SpriteComponent {
  Box({super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
          paint: Paint()..color = ColorExtension.fromRGBHexString('#14F596'),
        );
  @override
  Future<void>? onLoad() async {
    sprite = Sprite(await Flame.images.load('static/nine-box.png'));
    //paint = BasicPalette.green.paint();
    //setPaint(, paint)
    RectangleHitbox hitbox = RectangleHitbox.relative(
      Vector2.all(1),
      position: Vector2.all(0),
      parentSize: size,
    );
    //  hitbox.collisionType = CollisionType.passive;
    add(hitbox);
  }
}
