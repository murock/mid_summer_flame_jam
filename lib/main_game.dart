import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_garden_simulator/sprite_components/player.dart';

class MainGame extends FlameGame with MouseMovementDetector {
  late final Player player;

  @override
  Future<void>? onLoad() async {
    player = Player(
      position: size / 2,
      size: Vector2.all(100),
    );
    add(player);
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    player.onMouseMove(info);
  }
}
