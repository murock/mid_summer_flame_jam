import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

enum PlayerState {
  idle,
}

class Player extends SpriteAnimationGroupComponent with HasGameRef {
  Player({super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
        );

  Vector2? target;

  bool onTarget = false;

  static const speed = 200;
  static final Vector2 objSize = Vector2.all(50);
  Rect _toRect() => position.toPositionedRect(objSize);

  void onMouseMove(PointerHoverInfo info) {
    target = info.eventPosition.game;
  }

  @override
  Future<void>? onLoad() async {
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
  void update(double dt) {
    final target = this.target;
    super.update(dt);
    if (target != null) {
      onTarget = _toRect().contains(target.toOffset());

      if (!onTarget) {
        final dir = (target - position).normalized();
        position += dir * (speed * dt);
      }
    }
  }
}
