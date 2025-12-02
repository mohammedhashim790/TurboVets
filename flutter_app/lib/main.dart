import 'package:flutter/material.dart';
import 'package:flutter_app/theme.dart';
import 'package:flutter_app/views/splash/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/message.model.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(MessageModelAdapter());
  await Hive.openBox<MessageModel>('messages');
  runApp(const TurboApp());
}

class TurboApp extends StatefulWidget {
  const TurboApp({super.key});

  @override
  State<TurboApp> createState() => _TurboAppState();
}

class _TurboAppState extends State<TurboApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (_) {
          return Splash();
        },
      ),
    );
  }
}
