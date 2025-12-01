import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/views/home/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => Home()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<bool>(
          future: Future<bool>.delayed(Duration(seconds: 3), () => true),
          builder: (context, snapshot) {
            if (snapshot.hasData) {}

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(flex: 1, child: Image.asset("assets/ic.png")),
                Expanded(
                  flex: 1,
                  child: RichText(
                    text: TextSpan(
                      text: "POWERED BY ",
                      children: [TextSpan(text: "TurboVets")],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
