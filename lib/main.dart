import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:games/game/fruit_catcher_game.dart';

void main() {
  runApp(const MyGames());
}

class MyGames extends StatelessWidget {
  const MyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Games of Turtusi',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late FruitCatcherGame game;

  void initState() {
    super.initState();
    game = FruitCatcherGame();
  }
  final ValueNotifier<int> counter = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: game
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
                valueListenable: counter,
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                counter.value++;
              },
              child: const Text('Tambah Score'),
            ),
          ),
        ],
      ),
    );
  }
}
