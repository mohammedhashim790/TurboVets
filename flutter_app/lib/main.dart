import 'package:flutter/material.dart';
import 'package:flutter_app/views/splash/splash.dart';

void main() {
  runApp(const TurboApp());
}

class TurboApp extends StatelessWidget {
  const TurboApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (_) {
          return Splash();
        },
      ),
    );
  }
}
