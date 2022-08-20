import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
=import 'package:flutter/services.dart';
import 'package:flame/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mini_sprite/mini_sprite.dart';
import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';
import 'package:wildlife_garden_simulator/sprite_components/player.dart';

class Grid extends Component {
  List<List<RectangleComponent>> gridTable = [];

  @override
  Future<void>? onLoad() async {
    final miniLibrary = MiniSprite.fromDataString(grid);
    for (var i = 0; i < miniLibrary.pixels.length; i++) {
      List<RectangleComponent> lineRectangles = [];
      for (var j = 0; j < miniLibrary.pixels[i].length; j++) {
        var color = Colors.white;
        if (miniLibrary.pixels[i][j] == false) {
          color = Colors.black;
        }
        if (miniLibrary.pixels[i][j] == true) {
          color = Colors.white;
        }
        final rectangleComponent = RectangleComponent(
          position: Vector2((32 * j).toDouble(), (32 * i).toDouble()),
          size: Vector2.all(31.0),
          paint: Paint()..color = color,
        );
        lineRectangles.add(rectangleComponent);
        add(rectangleComponent);
      }
      gridTable.add(lineRectangles);
    }
  }

  Future<void>? changeColor(Color color) async {
    for (var i = 0; i < gridTable.length; i++) {
      for (var j = 0; j < gridTable[i].length; j++) {
        if (gridTable[i][j].paint.color != Colors.black) {
          final rectangleComponent = RectangleComponent(
            position: Vector2((32 * j).toDouble(), (32 * i).toDouble()),
            size: Vector2.all(31.0),
            paint: Paint()..color = color,
          );
          add(rectangleComponent);
        }
      }
    }
  }
}

class Flower extends Component {
  // TODO:
  //  -  draw the
  //  -  load a constant in contants
  //
}

class Seed extends Component {
  // TODO: load a constant in contants
}

class MainGame extends FlameGame
    with MouseMovementDetector, HasCollisionDetection, KeyboardEvents, HasTappables {
  late final Player player;
  late final Box box;
  late final Grid grid;


  // @override
  // Color backgroundColor() {
  //   // TODO: implement backgroundColor
  //   return Colors.red;
  // }

  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      grid.changeColor(Colors.blue);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }


  @override
  Future<void>? onLoad() async {
    debugMode = true;
    camera.viewport = FixedResolutionViewport(Vector2(
      Constants.resolutionX,
      Constants.resolutionY,
    ));
    grid = Grid();
    add(grid);
    player = Player(
      position: size / 2,
      size: Vector2.all(100),
    );
    add(player);
    box = Box(
      position: size / 4,
      size: Vector2.all(100),
    );

    add(box);
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    player.onMouseMove(info);
  }
}
