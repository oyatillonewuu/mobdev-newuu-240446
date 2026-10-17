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
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          ListTile(
            title: const Text("Profile"),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),
          ListTile(
            title: const Text("Messages"),
            leading: const Icon(Icons.message),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.messages);
            },
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),
        ],
      ),
    );
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
      body: Center(child: Text("$screenTitle Screen")),
    );
  }
}
