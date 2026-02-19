import 'dart:math';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/components/basket.dart';
import 'package:games/game/components/fruit.dart';
import 'package:games/game/managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Basket basket;
  late TextComponent scoreText;
  final Random random = Random();
  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5;

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(resolution:  Vector2(400, 800));

    basket = Basket();
    await add(basket);

    await AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.position.x += info.delta.global.x;
    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  void incrementScore() {
    scoreNotifier.value++;
    AudioManager().playSfx('sfx/collect.mp3');
  }

  void gameOver() {
    AudioManager().playSfx('sfx/explosion.mp3');
    pauseEngine();
  }

  @override
  Color backgroundColor() => const Color(0xFFB3E5FC);
}
