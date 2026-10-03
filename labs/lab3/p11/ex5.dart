Stream<int> yieldValuesDelayed(List<int> values, Duration delay) async* {
  for (var i in values) {
    await Future.delayed(delay);
    yield i;
  }
}

void main() async {
  final stream = yieldValuesDelayed([
    1,
    1,
    2,
    3,
    -1,
    4,
    5,
    5,
    6,
  ], Duration(milliseconds: 500));

  final transformedStream = stream
      .where((value) => value % 2 == 0)
      .map((value) => value * 3)
      .distinct();

  transformedStream.listen((data) async {
    print(data);
  });
}
