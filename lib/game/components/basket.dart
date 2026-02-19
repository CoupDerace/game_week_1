import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Basket extends PositionComponent with HasGameRef, CollisionCallbacks {
  Basket() : super(size: Vector2(80, 60));
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);


    final paint = Paint()
    ..color = const Color(0xFF4CAF50);
    ..style = PaintingStyle.fill;
    position.x = gameRef.size.x / 2;
  }
}
