import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart'; // Added for [Override]
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_ticker/models/tick.dart';
import 'package:riverpod_ticker/providers/ticker_providers.dart';
import 'package:riverpod_ticker/ticker_page.dart';

Widget harness(Override o) => ProviderScope(
  overrides: [o],
  child: const MaterialApp(home: TickerPage()),
  retry: (_, _) => null, // Disabling auto-retry
);
final sample = [
  Tick(symbol: 'BTC', price: 100, change: 1.5, at: DateTime(2026)),
];
void main() {
  testWidgets('loading shows spinner', (tester) async {
    await tester.pumpWidget(
      harness(
        tickerProvider.overrideWith((ref) => const Stream<List<Tick>>.empty()),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('data shows rows', (tester) async {
    await tester.pumpWidget(
      harness(tickerProvider.overrideWith((ref) => Stream.value(sample))),
    );
    await tester.pump();
    expect(find.text('BTC'), findsOneWidget);
    expect(find.textContaining('▲'), findsOneWidget);
  });
  testWidgets('error without data shows retry', (tester) async {
    await tester.pumpWidget(
      harness(
        tickerProvider.overrideWith((ref) => Stream<List<Tick>>.error('boom')),
      ),
    );
    await tester.pump();
    expect(find.text('Retry'), findsOneWidget);
    expect(find.byType(MaterialBanner), findsNothing);
  });
  testWidgets("error after data shows banner over rows", (tester) async {
    final controller = StreamController<List<Tick>>();
    await tester.pumpWidget(
      harness(tickerProvider.overrideWith((ref) => controller.stream)),
    );

    addTearDown(() {
      controller.close();
    });

    controller.add(sample);

    await tester.pump();

    expect(find.text('BTC'), findsOneWidget);

    controller.addError("Kaboom!");

    await tester.pumpAndSettle(); // pumps until every change to dirty settles

    expect(find.text('BTC'), findsOneWidget);
    expect(find.byType(MaterialBanner), findsOneWidget);
  });
}
