import 'package:api_catalog/apps.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products App")),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 10.0,
          children: [
            Text(
              "Meticiulously crafted by human.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductsApp()),
                );
              },
              child: const Text("Open catalog"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchApp()),
                );
              },
              child: const Text("Open search"),
            ),
          ],
        ),
      ),
    );
  }
}
