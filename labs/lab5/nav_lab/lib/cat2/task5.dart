import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const login = '/login';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Home"),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.profile);
          },
          child: const Text("Profile"),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Profile"),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Login"),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}

AppBar buildAppBarWithTitle(String title) {
  return AppBar(title: Text(title));
}
