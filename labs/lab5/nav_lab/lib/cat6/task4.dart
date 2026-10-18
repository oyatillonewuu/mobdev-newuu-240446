import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = "/";
  static const item = "/items/:id";
  static const settings = "/settings";
}

class AppRouteNames {
  static const home = "home";
  static const item = "item";
  static const settings = "settings";
}

final router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      name: AppRouteNames.home,
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: AppRouteNames.item,
      path: AppRoutes.item,
      builder: (context, state) {
        return ItemScreen(itemId: state.pathParameters["id"]!);
      },
    ),
    GoRoute(
      name: AppRouteNames.settings,
      path: AppRoutes.settings,
      builder: (context, state) {
        return const SettingsScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page not found")),
      body: Center(
        child: Column(
          spacing: 10.0,
          children: [
            Text(
              "404 | Page not found",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRouteNames.home),
              child: const Text("Go to Home"),
            ),
          ],
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
      appBar: AppBar(title: const Text("Items")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.go("4040!!!"),
            child: const Text("Trigger 404"),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final i in Iterable.generate(3))
                  ListTile(
                    title: Text("Item #${i + 1}"),
                    // Using pushNamed instead of goNamed. goNamed replaces.
                    onTap: () => context.pushNamed(
                      "item",
                      pathParameters: {"id": (i + 1).toString()},
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  final String itemId;
  const ItemScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Item detail")),
      body: Center(child: Text("Item #$itemId")),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(child: Text("Settings")),
    );
  }
}
