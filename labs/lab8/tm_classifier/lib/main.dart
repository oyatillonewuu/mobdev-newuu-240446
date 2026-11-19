import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tm_classifier/services/classifier.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final classifier = await Classifier.load();
  final ByteData bytes = await rootBundle.load("assets/model/sample.jpeg");
  final classificationResult = classifier.classify(bytes.buffer.asUint8List());
  print("");
  print("Prediction result for sample:");
  for (final pred in classificationResult) {
    print("${pred.label}: ${pred.confidence * 100}");
  }
  print(
    "Confidence sum: ${classificationResult.fold(0.0, (double s, pred) => s + pred.confidence)}",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
