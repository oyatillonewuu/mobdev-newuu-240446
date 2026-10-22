import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ticker_page.dart';
import 'providers/ticker_providers.dart';
import 'services/tick_feed.dart';

void main() => runApp(
  ProviderScope(
    retry: ((retryCount, error) => null),
    overrides: [tickFeedProvider.overrideWithValue(TickFeed(failAfter: 5))],
    child: TickerApp(),
  ),
);

class TickerApp extends StatelessWidget {
  const TickerApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ticker',
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const TickerPage(),
  );
}
