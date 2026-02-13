import 'package:flutter/material.dart';

void main(){
  runApp( MyGames() 
  );
}

class MyGames extends StatelessWidget {
  const MyGames({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Games of Turtusi',
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Game akan dimulai sebentar lagi!'),
      ),
    );
  }
}