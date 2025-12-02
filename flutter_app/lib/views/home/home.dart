import 'package:flutter/material.dart';
import 'package:flutter_app/views/chat_window/chat_window.dart';

import '../dashboard/dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _pages = [ChatWindow(), Dashboard()];
  final List<String> _pagesTitle = ["Chat", "Dashboard"];

  int _selected = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D3A),
            borderRadius: BorderRadius.circular(25), // Rounded container
          ),
          child: Row(
            children: List.generate(_pagesTitle.length, (index) {
              // Determine if this specific tab is active
              bool isActive = index == _selected;

              return Expanded(
                child: GestureDetector(
                  // 2. The Logic: Update state on tap
                  onTap: () {
                    setState(() {
                      _selected = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.blueAccent : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _pagesTitle[index],
                      style: TextStyle(
                        color: isActive ? Colors.white : Colors.grey,
                        fontWeight: isActive
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body: SafeArea(
        // Best to use Page transition builder or pageview for widget optimisation
        // Indexed stack works best to void rerender.
        child: IndexedStack(index: _selected, children: _pages),
      ),
    );
  }
}
