import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/fruit_catcher_game.dart';
import 'package:games/game/managers/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager().initialize();
  await AudioManager().playBackgroundMusic();
  runApp(const MyGames());
}

class MyGames extends StatelessWidget {
  const MyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Games of Turtusi', home: GameScreen());
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late FruitCatcherGame game;

  @override
  void dispose() {
    game.onRemove();
    super.dispose();
  }

  void initState() {
    super.initState();
    game = FruitCatcherGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: game),

          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ValueListenableBuilder<int>(
                  valueListenable: game.timeLeftNotifier,
                  builder: (context, time, child) {
                    return Text(
                      'Time: $time',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          ValueListenableBuilder<int>(
            valueListenable: game.timeLeftNotifier,
            builder: (context, time, child) {
              if (time == 0) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'GAME OVER',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          game.resetGame();
                        },
                        child: const Text('RESTART'),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),

          Positioned(
            top: 50,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ValueListenableBuilder<int>(
                valueListenable: game.scoreNotifier,
                builder: (context, score, child) {
                  return Text(
                    'Score: $score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.music_note),
                  onPressed: () {
                    AudioManager().toggleMusic();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    AudioManager().toggleSfx();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
