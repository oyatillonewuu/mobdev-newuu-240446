mixin Flyable {
  void fly() {
    print("I'm flying");
  }
}

class Bird with Flyable;

void main() {
  Bird b = Bird();
  b.fly();
}
