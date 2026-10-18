import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slide animation")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const DetailsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      final tween = Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero,
                      );
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
              ),
            );
          },
          child: const Text("Details"),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Details")),
      body: Center(
        child: const Text(
          "Details",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
