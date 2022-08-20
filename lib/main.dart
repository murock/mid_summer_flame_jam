import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_garden_simulator/main_game.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends MainGame {}
