import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Home"),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Greet"),
              onPressed: () {
                final userInput = _textEditingController.text;
                _textEditingController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GreetingScreen(name: userInput),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBarWithTitle(String title) {
  return AppBar(title: Text(title));
}

class GreetingScreen extends StatelessWidget {
  final String name;
  const GreetingScreen({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWithTitle("Greet"),
      body: Center(child: Text("Hello, $name")),
    );
  }
}
