import "dart:io";

enum TrafficLightState {
  red,
  yellow,
  green;

  static TrafficLightState? nextState(
    TrafficLightState prevState,
    TrafficLightState curState,
  ) {
    return switch ((prevState, curState)) {
      (TrafficLightState.red, TrafficLightState.red) =>
        TrafficLightState.yellow,
      (TrafficLightState.green, TrafficLightState.green) =>
        TrafficLightState.yellow,
      (TrafficLightState.yellow, TrafficLightState.yellow) =>
        TrafficLightState.green,
      (TrafficLightState.red, TrafficLightState.yellow) =>
        TrafficLightState.green,
      (TrafficLightState.yellow, TrafficLightState.green) =>
        TrafficLightState.yellow,
      (TrafficLightState.green, TrafficLightState.yellow) =>
        TrafficLightState.red,
      (TrafficLightState.yellow, TrafficLightState.red) =>
        TrafficLightState.yellow,
      _ => null,
    };
  }
}

class TrafficLight {
  TrafficLightState _prevState = TrafficLightState.red;
  TrafficLightState _curState = TrafficLightState.red;

  String get currentState {
    return _curState.name;
  }

  void changeState() {
    TrafficLightState newState = TrafficLightState.nextState(
      _prevState,
      _curState,
    )!;
    _prevState = _curState;
    _curState = newState;
  }
}

void main() {
  TrafficLight trafficLight = TrafficLight();

  while (true) {
    print(trafficLight.currentState);
    sleep(Duration(seconds: 2));
    trafficLight.changeState();
  }
}
