import 'package:flutter/material.dart';

class ScreenArgs {
  final int num;

  const ScreenArgs(this.num);
}

class AppRoutes {
  static const home = "/";
  static const square = "/square";
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Numbers"),
      body: ListView(
        children: [
          for (final num in Iterable.generate(6))
            ListTile(
              title: Text(":> $num"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.square,
                  arguments: ScreenArgs(num),
                );
              },
            ),
        ],
      ),
    );
  }
}

class SquareScreen extends StatelessWidget {
  const SquareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArgs;
    final num = args.num;

    return Scaffold(
      appBar: buildAppBarWithTitle("Square"),
      body: Column(
        children: [
          Text("Number passed: $num"),
          SizedBox(height: 20.0),
          Text("$num^2 = ${num * num}"),
        ],
      ),
    );
  }
}

AppBar buildAppBarWithTitle(String title) {
  return AppBar(title: Text(title));
}
