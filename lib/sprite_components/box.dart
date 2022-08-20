import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Box extends SpriteComponent with Tappable {
  Box({super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
          paint: Paint()..color = ColorExtension.fromRGBHexString('#14F596'),
        );

  bool isTouching = false;
  bool isInteracting = false;

  bool wantToInteract = false;

  // Test code delete late
  late final Sprite sprite1;
  late final Sprite sprite2;
  bool showingOne = true;

  void onInteractAreaEnter() {
    print('set to true');
    isInteracting = true;
  }

  void onInteractAreaExit() {
    print('set to false');
    isInteracting = false;
  }

  void checkIfWantToInteract() {
    if (wantToInteract) {
      if (showingOne) {
        sprite = sprite2;
        showingOne = false;
      } else {
        sprite = sprite1;
        showingOne = true;
      }
      wantToInteract = false;
    }
  }

  @override
  Future<void>? onLoad() async {
    sprite1 = Sprite(await Flame.images.load('static/3_stages_plant.png'));
    sprite2 = Sprite(await Flame.images.load('static/nine-box.png'));
    sprite = sprite1;
    RectangleHitbox interactionHitbox = RectangleHitbox.relative(
      Vector2.all(1),
      position: Vector2((-size.x / 2) - 25, (-size.y / 2) - 25),
      parentSize: size * 2.5,
    );

    interactionHitbox.onCollisionCallback =
        (intersectionPoints, other) => checkIfWantToInteract();

    // interactionHitbox.onCollisionStartCallback =
    //     (intersectionPoints, other) => onInteractAreaEnter();
    // interactionHitbox.onCollisionEndCallback = (other) => onInteractAreaExit();
    interactionHitbox.collisionType = CollisionType.passive;
    add(interactionHitbox);

    RectangleHitbox hitbox = RectangleHitbox();
    hitbox.collisionType = CollisionType.passive;
    hitbox.onCollisionStartCallback =
        (intersectionPoints, other) => isTouching = true;
    hitbox.onCollisionEndCallback = (other) => isTouching = false;

    add(hitbox);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    wantToInteract = true;
    return super.onTapUp(info);
  }
}
