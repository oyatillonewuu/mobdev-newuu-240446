import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, "/does-not-exist");
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          child: const Text("Open 404"),
        ),
      ),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericScreenWithTitle("404");
  }
}

class GenericScreenWithTitle extends StatelessWidget {
  final String screenTitle;
  const GenericScreenWithTitle(this.screenTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(screenTitle)),
      body: Center(child: Text("$screenTitle Screen")),
    );
  }
}
