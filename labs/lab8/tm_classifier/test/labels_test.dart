import 'package:test/test.dart';

import 'package:tm_classifier/services/classifier.dart' show parseLabels;

void main() {
  test("Normal case", () {
    final labels = parseLabels("0 Mug\n1 Bottle\n");
    expect(labels, ["Mug", "Bottle"]);
  });
  test("Awkward case", () {
    final labels = parseLabels("0 Car keys\n\r1 Bottle\n\r \n");
    expect(labels, ["Car keys", "Bottle"]);
  });
}
