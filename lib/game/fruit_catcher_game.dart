import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/components/basket.dart';
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
  Color backgroundColor() => const Color(0xFFB3E5FC);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(Vector2(400, 800));

    basket = Basket();
    await add(basket);
    
    AudioManager().playBackgroundMusic();
  }
}
