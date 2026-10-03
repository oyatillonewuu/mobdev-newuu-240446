Stream<int> yieldValuesDelayed(List<int> values, Duration delay) async* {
  for (var i in values) {
    await Future.delayed(delay);
    yield i;
  }
  throw "Dummy error";
}

void handleError(dynamic e) {
  print("Stream error handler: received error `$e`");
}

void consumeStream(Stream<int> numStream) {
  numStream.listen(
    (value) {
      print(value);
    },
    onDone: () => print("Consumption done."),
    onError: (e) => handleError(e),
    cancelOnError: false,
  );
}

void main() {
  consumeStream(
    yieldValuesDelayed(
      Iterable<int>.generate(10).toList(),
      Duration(milliseconds: 300),
    ),
  );
}
