import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Color squareColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Square")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 20.0,
          children: [
            const SizedBox(height: 100),
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(color: squareColor),
            ),
            ElevatedButton(
              onPressed: () async {
                final color = (await Navigator.push<Color>(
                  context,
                  MaterialPageRoute(builder: (context) => const ColorsScreen()),
                ));

                if (color != null) {
                  setState(() {
                    squareColor = color;
                  });
                }
              },
              child: const Text("Pick color", style: TextStyle(fontSize: 22.0)),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorsScreen extends StatelessWidget {
  const ColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pick color")),
      body: const Column(
        children: [
          SizedBox(height: 100.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5.0,
            children: [
              SizedBox(height: 15.0),
              ColorButton(color: Colors.red),
              ColorButton(color: Colors.indigo),
              ColorButton(color: Colors.amber),
            ],
          ),
        ],
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  const ColorButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: color,
        fixedSize: Size(15.0, 15.0),
      ),
      onPressed: () {
        Navigator.pop(context, color);
      },
      child: null,
    );
  }
}
