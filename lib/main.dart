import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:wildlife_garden_simulator/main_game.dart';

void main() {
  MyGame mainGame = MyGame();
  runApp(
    GameWidget(
      game: mainGame,
      overlayBuilderMap: {
        'GameOver': (ctx, _) {
          return _buildGameOverMenu(
            score: mainGame.score,
          );
        }
      },
    ),
  );
}

Widget _buildGameOverMenu({
  required int score,
}) {
  return Center(
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
          vertical: 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Text(
              'score is ${score.toInt()}',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            // IconButton(
            //   onPressed: () => restartGame(),
            //   icon: const Icon(Icons.replay),
            //   iconSize: 60,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    ),
  );
}

class MyGame extends MainGame {}
