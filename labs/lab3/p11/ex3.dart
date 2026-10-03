Future<String> getAndPrintMessageAfterDelay(String msg, Duration delay) {
  return Future.delayed(delay, () {
    print(msg);
    return msg;
  });
}

void main() async {
  var task1 = getAndPrintMessageAfterDelay("Async", Duration(seconds: 2));
  var task2 = getAndPrintMessageAfterDelay(
    "Dart",
    Duration(seconds: 1, milliseconds: 500),
  );
  var task3 = getAndPrintMessageAfterDelay("rusty", Duration(seconds: 1));

  List<String> res = await Future.wait([task1, task2, task3]);

  print("Aggregated result: $res");
}
