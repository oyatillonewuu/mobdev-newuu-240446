import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scale x Fade")),
      body: Row(
        spacing: 15.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const DetailsScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final curve = Curves.easeInOut;
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: curve,
                        );
                        final tween = Tween<double>(begin: 0.8, end: 1.0);
                        return FadeTransition(
                          opacity: curvedAnimation,
                          child: ScaleTransition(
                            scale: tween.animate(curvedAnimation),
                            child: child,
                          ),
                        );
                      },
                ),
              );
            },
            child: const Text("Details"),
          ),
        ],
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
