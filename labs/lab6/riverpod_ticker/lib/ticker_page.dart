import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/ticker_providers.dart';
import 'widgets/tick_row.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticks = ref.watch(tickerProvider);
    debugPrint("$ticks");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live ticker'),
        actions: [
          IconButton(
            icon: Icon(Icons.error),
            onPressed: () =>
                ref.read(failAfterProvider.notifier).update((state) {
                  return switch (state) {
                    null => 5,
                    _ => null,
                  };
                }),
          ),
        ],
      ),
      body: switch (ticks) {
        // Loading with past values in progress, keep rows, show thin progress bar
        AsyncValue(:final value?, isLoading: true) => Column(
          children: [
            const LinearProgressIndicator(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(tickerProvider.future),
                child: Opacity(
                  opacity: 0.5,
                  child: ListView(
                    children: [
                      for (final t in value)
                        TickRow(t, key: ValueKey(t.symbol)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // Error with stale data: show rows dimmed, banner on top
        AsyncError(:final error, :final value?) => Column(
          children: [
            MaterialBanner(
              content: Text('Feed error: $error — showing last prices'),
              actions: [
                TextButton(
                  onPressed: () => ref.refresh(tickerProvider.future),
                  child: const Text('Retry'),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(tickerProvider.future),
                child: Opacity(
                  opacity: 0.5,
                  child: ListView(
                    children: [
                      for (final t in value)
                        TickRow(t, key: ValueKey(t.symbol)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // Error with loading in progress but with no past values
        AsyncError(isLoading: true) => const Center(
          child: CircularProgressIndicator(),
        ),
        // Error with nothing to show
        AsyncError(:final error) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Could not load ticker\n$error',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () => ref.refresh(tickerProvider.future),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        // Data from healthy and stable stream
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: () => ref.refresh(tickerProvider.future),
          child: ListView(
            children: [
              for (final t in value) TickRow(t, key: ValueKey(t.symbol)),
            ],
          ),
        ),
        // Cold start load
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
