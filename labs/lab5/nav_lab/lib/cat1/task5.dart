import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LinkedScreen(
      appBarColors: (bgColor: Colors.amber, fgColor: Colors.white),
      screenTitle: "A",
      nextScreen: LinkedScreen(
        appBarColors: (bgColor: Colors.blue, fgColor: Colors.white),
        screenTitle: "B",
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
        leadingWidth: 100,
        leading: const BackOrExitButton(),
        title: Text(screenTitle),
        backgroundColor: appBarColors.bgColor,
        foregroundColor: appBarColors.fgColor,
        actions: [NextButton(nextScreen: _nextScreen)],
      ),
    );
  }
}

class BackOrExitButton extends StatelessWidget {
  const BackOrExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (Navigator.canPop(context))
          ? () {
              Navigator.pop(context);
            }
          : null,
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.blueGrey,
        disabledForegroundColor: Colors.grey,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: const Text("Back"),
    );
  }
}

class NextButton extends StatelessWidget {
  final LinkedScreen? _nextScreen;
  const NextButton({this._nextScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (_nextScreen != null)
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _nextScreen),
              );
            }
          : null,
      style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.blueGrey,
        disabledForegroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: const Text("Next"),
    );
  }
}
