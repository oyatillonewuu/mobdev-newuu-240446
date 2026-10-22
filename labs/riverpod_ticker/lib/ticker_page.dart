import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ticker")),
      body: Center(child: const Text("Ticker")),
    );
  }
}
