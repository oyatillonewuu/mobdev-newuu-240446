// Code doesn't compile

abstract class Human {}

abstract class TuringMachine {}

abstract class Animal {}

mixin SomeHumanCapabilities on Human {
  void speak(String sentence) {
    print(sentence);
  }

  void think() {
    print("Thought...");
  }
}

class Citizen extends Human with SomeHumanCapabilities {
  String name;
  new(this.name);
}

void main() {
  Citizen c = Citizen("Tony Stark Iron Man");
  c.speak("I am Iron Man");
  c.think();
}
