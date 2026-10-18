import 'package:flutter/material.dart';

class User {
  final String name;
  final int age;
  final String city;

  const User(this.name, this.age, this.city);
}

const List<User> users = [
  User("Jack", 19, "Marsi"),
  User("Liz", 20, "Ven"),
  User("Albert", 35, "Time"),
  User("Dirak", 45, "Quant"),
];

class ScreenArgs {
  final User user;

  const ScreenArgs(this.user);
}

class AppRoutes {
  static const home = "/";
  static const profile = "/profile";
}

// Learned from Google AI Overview
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AppRoutes.profile:
        if (args is ScreenArgs) {
          return MaterialPageRoute(
            builder: (context) => ProfileScreen(user: args.user),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) => ErrorScreen());
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
        leading: Navigator.canPop(context) ? const BackButton() : null,
      ),
      body: Center(
        child: const Text(
          "404 | Resource not found",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Center(
        child: ListView(
          children: [
            for (final user in users)
              ListTile(
                title: Text(user.name),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.profile,
                    arguments: ScreenArgs(user),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(("User profile"))),
      body: Center(
        child: Column(
          children: [
            Text("Name: ${user.name}"),
            SizedBox(height: 20.0),
            Text("Age: ${user.age}"),
            SizedBox(height: 20.0),
            Text("City: ${user.city}"),
          ],
        ),
      ),
    );
  }
}
