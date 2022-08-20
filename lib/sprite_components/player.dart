import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';

enum PlayerState {
  idle,
}

class Player extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameRef {
  Player({super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
        );

  Vector2? target;

  bool onTarget = false;

  static const speed = 600;
  static final Vector2 objSize = Vector2.all(50);
  Rect _toRect() => position.toPositionedRect(objSize);

  void onMouseMove(PointerHoverInfo info) {
    target = info.eventPosition.game;
  }

  @override
  Future<void>? onLoad() async {
    // RectangleHitbox hitbox = RectangleHitbox.relative(
    //   Vector2.all(1),
    //   position: Vector2.all(0),
    //   parentSize: size,
    // );
    // add(hitbox);
    add(CircleHitbox());

    final idle = await gameRef.loadSpriteAnimation(
      'animations/ember.png',
      SpriteAnimationData.sequenced(
        amount: 3,
        textureSize: Vector2.all(16),
        stepTime: 0.15,
      ),
    );

    animations = {
      PlayerState.idle: idle,
    };

    current = PlayerState.idle;
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Box) {
      if (intersectionPoints.length == 2) {
        // Calculate the collision normal and separation distance.
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        // Resolve collision by moving player along
        // collision normal by separation distance.
        position += collisionNormal.scaled(separationDistance);
      }
    }
  }

  @override
  void update(double dt) {
    final target = this.target;
    super.update(dt);
    if (target != null) {
      onTarget = _toRect().contains(target.toOffset());

      if (!onTarget) {
        final dir = (target - position).normalized();
        position += dir * (speed * dt);
      }

      if (position.y < 0) {
        position.y = 0;
      } else if (position.y > Constants.resolutionY) {
        position.y = Constants.resolutionY;
      }

      if (position.x < 0) {
        position.x = 0;
      } else if (position.x > Constants.resolutionX) {
        position.x = Constants.resolutionX;
      }
    }
  }
}
