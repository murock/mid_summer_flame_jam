import 'package:flame/components.dart';
import 'dart:math' as math;

double getDistanceBetweenPoints(
  Vector2 pos1,
  Vector2 pos2,
) {
  var x1 = pos1.x;
  var y1 = pos1.y;
  var x2 = pos2.x;
  var y2 = pos2.y;
  return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2));
}
