import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tm_classifier/services/classifier.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  runApp(ProviderScope(child: const Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Amateur classifier")),
        body: const Startup(),
      ),
    );
  }
}

class Startup extends ConsumerWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Classifier> classifier = ref.watch(classifierProvider);

    return classifier.when(
      loading: () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
          Center(child: const Text("Loading classifier, please wait...")),
          Center(
            child: const CircularProgressIndicator(
              semanticsLabel: "Loading classifier...",
            ),
          ),
        ],
      ),
      error: (_, _) => const Text("Failed to load model. Try relaunching."),
      data: (data) => MainApp(),
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends ConsumerState<MainApp> {
  PredictionResult? _lastPrediction;

  @override
  Widget build(BuildContext context) {
    AsyncValue<Classifier> clf = ref.watch(classifierProvider);
    return switch (clf) {
      AsyncData(value: final classifier) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.0,
        children: [
          PredictionsWidget(predictionResult: _lastPrediction),
          SizedBox(height: 50.0),
          ElevatedButton(
            onPressed: () async {
              if (!context.mounted) return;
              final List<Prediction>? predictions = makePrediction(
                classifier: classifier,
                bytes: (await rootBundle.load("assets/model/sample.jpeg"))
                    .buffer
                    .asUint8List(),
                context: context,
              );
              if (predictions == null) return;
              setState(() {
                _lastPrediction = PredictionResult(
                  predictions: predictions,
                  imagePath: "assets/model/sample.jpeg",
                );
              });
            },
            child: const Text("Predict on sample image"),
          ),
          ElevatedButton(
            onPressed: () async {
              final List<Prediction>? predictions = makePrediction(
                classifier: classifier,
                bytes: Uint8List.fromList([1, 2, 3, 4]),
                context: context
              );
              if (predictions == null) return;
              setState(() {
                _lastPrediction = PredictionResult(
                  predictions: predictions,
                  imagePath: "assets/model/sample.jpeg",
                );
              });
            },
            child: const Text("Predict on invalid image bytes"),
          ),
        ],
      ),
      _ => const Text("Fatal crash"),
    };
  }
}

List<Prediction>? makePrediction({
  required Classifier classifier,
  required Uint8List bytes,
  required BuildContext context,
}) {
  try {
    return classifier.classify(bytes);
  } catch (e) {
    if (!context.mounted) return null;
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: const Text("Dismiss"),
          ),
        ],
      ),
    );
  }
  return null;
}

class PredictionsWidget extends StatelessWidget {
  const PredictionsWidget({super.key, this.predictionResult});

  final PredictionResult? predictionResult;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Prediction Result"),
          SizedBox(height: 20.0),
          if (predictionResult == null) const Text("(no predictions yet)"),
          if (predictionResult != null)
            Image.asset(
              predictionResult!.imagePath,
              bundle: rootBundle,
              width: 250.0,
            ),
          SizedBox(height: 20.0),
          if (predictionResult != null)
            for (final pred in predictionResult!.predictions)
              Text("${pred.label}: ${pred.confidence.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
