import 'dart:async';

Stream<int> timedCounter(Duration delay, int maxCount) async* {
  int i = 0;
  while (i < maxCount) {
    await Future.delayed(delay);
    yield i++;
  }
}

void main() async {
  var stream = timedCounter(Duration(milliseconds: 300), 200);
  late StreamSubscription<int> subscription;

  int emissionCount = 0;

  subscription = stream.listen((data) async {
    print(data);

    emissionCount++;
    if (emissionCount == 5) {
      await subscription.cancel();
    }
  });
}
