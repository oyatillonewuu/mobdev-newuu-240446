import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Slide right+bottom")),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const DetailsScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        final begin = Offset(0, 1);
                        final end = Offset.zero;
                        final curve = Curves.easeOut;

                        final tween = Tween<Offset>(begin: begin, end: end);
                        final curvedAnimation = CurvedAnimation(
                          parent: animation,
                          curve: curve,
                        );

                        return SlideTransition(
                          position: tween.animate(curvedAnimation),
                          child: child,
                        );
                      },
                ),
              );
            },
            child: const Text("Open as sheet"),
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
