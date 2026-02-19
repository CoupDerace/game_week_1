import 'dart:math';
import 'dart:async' as async;
import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/components/basket.dart';
import 'package:games/game/components/fruit.dart';
import 'package:games/game/managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Basket basket;
  final Random random = Random();

  double fruitSpawnTimer = 0;
  final double fruitSpawnInterval = 1.5;

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> timeLeftNotifier = ValueNotifier<int>(15);

  async.Timer? countdownTimer;

  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    basket = Basket();
    await add(basket);

    startTimer();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return;

    fruitSpawnTimer += dt;

    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  void startTimer() {
    countdownTimer?.cancel();

    countdownTimer = async.Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeftNotifier.value > 0) {
        timeLeftNotifier.value--;
      } else {
        timer.cancel();
        gameOver();
      }
    });
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (isGameOver) return;

    basket.position.x += info.delta.global.x;

    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  void incrementScore() {
    if (isGameOver) return;

    scoreNotifier.value++;
    AudioManager().playSfx('sfx/collect.mp3');
  }

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;

    AudioManager().playSfx('sfx/explosion.mp3');

    pauseEngine();
    countdownTimer?.cancel();

    debugPrint('Game Over! Final Score: ${scoreNotifier.value}');
  }

  @override
  Color backgroundColor() => const Color(0xFFB3E5FC);

  @override
  void onRemove() {
    countdownTimer?.cancel();
    super.onRemove();
  }

  void resetGame() {
    isGameOver = false;

    scoreNotifier.value = 0;
    timeLeftNotifier.value = 15;

    children.whereType<Fruit>().forEach((fruit) {
      fruit.removeFromParent();
    });

    basket.position = Vector2(size.x / 2, size.y - 100);

    resumeEngine();
    startTimer();
  }
}
