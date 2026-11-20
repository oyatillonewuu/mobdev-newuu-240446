import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class PredictionResult {
  final List<Prediction> predictions;
  final String imagePath;

  PredictionResult({required this.predictions, required this.imagePath});
}

class Prediction {
  const Prediction(this.label, this.confidence);
  final String label;
  final double confidence;
}

// 0.0 to 1.0
/// "0 Mug\n1 Bottle\n" becomes ['Mug', 'Bottle']. Pure, so it is unit-testable.
List<String> parseLabels(String raw) => [
  for (final line in raw.split('\n'))
    if (line.trim().isNotEmpty)
      line.trim().replaceFirst(RegExp(r'^\d+\s+'), ''),
];

class Classifier {
  Classifier._(this._interpreter, this.labels);
  final Interpreter _interpreter;
  final List<String> labels;
  static const inputSize = 224;
  static Future<Classifier> load() async {
    // 1.
    final interpreter = await Interpreter.fromAsset(
      'assets/model/model_unquant.tflite',
    );
    final labels = parseLabels(
      await rootBundle.loadString('assets/model/labels.txt'),
    );
    return Classifier._(interpreter, labels);
  }

  List<Prediction> classify(Uint8List bytes) {
    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw const FormatException('Not a readable image');
    final square = img.copyResizeCropSquare(
      img.bakeOrientation(decoded),
      size: inputSize,
    );
    final input = [
      List.generate(
        inputSize,
        (y) => List.generate(inputSize, (x) {
          final p = square.getPixel(x, y);
          return [p.r / 127.5 - 1, p.g / 127.5 - 1, p.b / 127.5 - 1];
        }),
      ),
    ];
    final output = [List<double>.filled(labels.length, 0)];
    _interpreter.run(input, output);
    // 2.
    // 3. shape [1, 224, 224, 3]
    // 4. shape [1, classes]
    return [
      for (var i = 0; i < labels.length; i++)
        Prediction(labels[i], output.first[i]),
    ]..sort((a, b) => b.confidence.compareTo(a.confidence));
    // 5.
  }

  void close() => _interpreter.close();
}

final classifierProvider = FutureProvider<Classifier>((ref) async {
  final classifier = await Classifier.load();
  if (ref.mounted) {
    ref.onDispose(() => classifier.close());
  }
  return classifier;
});
