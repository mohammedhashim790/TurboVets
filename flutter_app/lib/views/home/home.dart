import 'package:flutter/material.dart';
import 'package:flutter_app/views/chat_window/chat_window.dart';
import 'package:flutter_app/views/utils/extensions.dart';

import '../utils/drawer/drawer_action_button.dart';
import '../utils/drawer/drawer_title.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _pages = [ChatWindow(), ChatWindow()];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            padding: EdgeInsets.only(top: 50.0),
            children: [
              DrawerActionButton(
                icon: Icon(Icons.dashboard),
                text: "Dashboard",
                onTap: () {
                  setState(() {
                    _selected = 1;
                  });
                  context.pop();
                },
              ),
              DrawerActionButton(
                icon: Icon(Icons.add),
                text: "New Chat",
                onTap: () {
                  setState(() {
                    _selected = 0;
                  });
                  context.pop();
                },
              ),
              DrawerTitle(title: "Chat List"),
              //   Load chat session here and render
            ],
          ),
        ),
      ),
      body: SafeArea(
        // Best to use Page transition builder or pageview for widget optimisation
        child: _pages.elementAt(_selected),
      ),
    );
  }
}
