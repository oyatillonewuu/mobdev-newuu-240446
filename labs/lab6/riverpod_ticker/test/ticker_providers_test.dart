import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_ticker/models/tick.dart';
import 'package:riverpod_ticker/providers/ticker_providers.dart';
import 'package:riverpod_ticker/services/tick_feed.dart';

import 'dart:async';

void main() {
  test('starts loading, then emits data', () async {
    final container = ProviderContainer(
      overrides: [
        tickFeedProvider.overrideWithValue(TickFeed(symbols: const ['BTC'])),
      ],
    );
    addTearDown(container.dispose);
    // Added this. The lab file's code is WRONG (the provider is autoDispose;
    // read is not a listener; thus, no active listener -> disposal
    // by the time of the second read).
    final sub = container.listen(tickerProvider, (_, _) {});
    expect(container.read(tickerProvider), isA<AsyncLoading<Object?>>());
    final first = await container.read(tickerProvider.future);
    expect(first.single.symbol, 'BTC');
    expect(container.read(tickerProvider).hasValue, isTrue);
    sub.close();
  });
  test('surfaces FeedException as AsyncError with previous value', () async {
    final container = ProviderContainer(
      overrides: [
        tickFeedProvider.overrideWithValue(
          TickFeed(symbols: const ['BTC'], failAfter: 1),
        ),
      ],
      retry: (_, _) => null, // Disabling retry for test 2 run reliably
    );
    addTearDown(container.dispose);
    final errored = Completer<AsyncValue<List<Tick>>>();
    final sub = container.listen(tickerProvider, (_, next) {
      if (next is AsyncError && !errored.isCompleted) {
        errored.complete(next);
      }
    });

    addTearDown(sub.close);

    final state = await errored.future.timeout(
      const Duration(seconds: 25),
    ); // 25s timeout
    expect(state, isA<AsyncError<Object?>>());
    expect(state.hasValue, isTrue, reason: 'previous ticks are kept');
    expect(state.error, isA<FeedException>());
  });
}
