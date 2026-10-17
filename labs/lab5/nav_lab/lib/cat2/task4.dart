import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const profile = '/profile';
  static const messages = '/messages';
  static const about = '/about';
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericScreenWithTitle("Home");
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: const Text("Draw"),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () => _navigateTo(context, AppRoutes.home),
          ),
          ListTile(
            title: const Text("Profile"),
            onTap: () => _navigateTo(context, AppRoutes.profile),
          ),
          ListTile(
            title: const Text("Messages"),
            onTap: () => _navigateTo(context, AppRoutes.messages),
          ),
          ListTile(
            title: const Text("About"),
            onTap: () => _navigateTo(context, AppRoutes.about),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, route);
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericScreenWithTitle("Profile");
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericScreenWithTitle("Messages");
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericScreenWithTitle("About");
  }
}

class GenericScreenWithTitle extends StatelessWidget {
  final String screenTitle;
  const GenericScreenWithTitle(this.screenTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(screenTitle)),
      drawer: const AppDrawer(),
      body: Center(child: Text("$screenTitle Screen")),
    );
  }
}
