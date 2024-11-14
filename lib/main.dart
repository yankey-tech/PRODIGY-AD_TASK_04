import 'package:flutter/material.dart';
import 'package:tic_tac_toe/loadingScreen.dart';
import 'package:tic_tac_toe/gameScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: '/',
      routes: {
         '/': (context) => LoadingScreen(),
        '/game': (context) => GameScreen()
      },
    );
  }
}

