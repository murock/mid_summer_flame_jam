import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:wildlife_garden_simulator/constants.dart';
import 'package:wildlife_garden_simulator/sprite_components/box.dart';

enum PlayerState { idle, right, left, down, up }

class Player extends SpriteAnimationGroupComponent
    with CollisionCallbacks, HasGameRef {
  Player({super.position, Vector2? size, super.priority})
      : super(
          size: size ?? Vector2.all(50),
          anchor: Anchor.center,
        );

  static const speed = 600;

  bool facingRight = true;

  @override
  Future<void>? onLoad() async {
    add(CircleHitbox());

    final idle = await _getPlayerAnimation(
      amount: 4,
      xLocation: 0,
      yLocation: 0,
    );
    final across = await _getPlayerAnimation(
      amount: 8,
      xLocation: 0,
      yLocation: 3,
    );
    final down = await _getPlayerAnimation(
      amount: 8,
      xLocation: 0,
      yLocation: 4,
    );
    final up = await _getPlayerAnimation(
      amount: 8,
      xLocation: 0,
      yLocation: 5,
    );

    animations = {
      PlayerState.idle: idle,
      PlayerState.right: across,
      PlayerState.left: across,
      PlayerState.down: down,
      PlayerState.up: up,
    };

    current = PlayerState.idle;
    return super.onLoad();
  }

  Future<SpriteAnimation> _getPlayerAnimation({
    required int amount,
    required double xLocation,
    required double yLocation,
  }) async {
    double playerWidth = 32;
    double playerHeight = 32;
    double xPos = playerWidth * xLocation;
    double yPos = playerHeight * yLocation;
    return await SpriteAnimation.load(
      'animations/player.png',
      SpriteAnimationData.sequenced(
        amount: amount,
        textureSize: Vector2(
          playerWidth,
          playerHeight,
        ),
        stepTime: 0.1,
        texturePosition: Vector2(xPos, yPos),
        loop: true,
      ),
    );
  }

  void faceRight() {
    if (!facingRight) {
      flipHorizontallyAroundCenter();
      facingRight = true;
    }
  }

  void faceLeft() {
    if (facingRight) {
      flipHorizontallyAroundCenter();
      facingRight = false;
    }
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
    super.update(dt);

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
