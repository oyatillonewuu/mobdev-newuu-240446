import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LinkedScreen(
      appBarColors: (bgColor: Colors.amber, fgColor: Colors.white),
      screenTitle: "Step 1",
      nextScreen: LinkedScreen(
        appBarColors: (bgColor: Colors.green, fgColor: Colors.white),
        screenTitle: "Step 2",
        nextScreen: LinkedScreen(
          appBarColors: (bgColor: Colors.blue, fgColor: Colors.white),
          screenTitle: "Step 3",
          nextScreen: LinkedScreen(
            appBarColors: (bgColor: Colors.orange, fgColor: Colors.white),
            screenTitle: "Step 4",
          ),
        ),
      ),
    );
  }
}

class LinkedScreen extends StatelessWidget {
  final LinkedScreen? _nextScreen;
  final String screenTitle;
  final ({Color bgColor, Color fgColor}) appBarColors;

  const LinkedScreen({
    required this.screenTitle,
    required this.appBarColors,
    this._nextScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
        backgroundColor: appBarColors.bgColor,
        foregroundColor: appBarColors.fgColor,
        actions: [
          if (_nextScreen != null)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _nextScreen),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text("Next"),
            ),
          if (_nextScreen == null)
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text("Finish"),
            ),
        ],
      ),
    );
  }
}
