import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame{
  @override
  Color backgroundColor() => const Color(0xFFB3E5FC);

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    AudioManager().playBackgroundMusic();
  }
}