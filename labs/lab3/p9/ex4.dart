mixin Walker {
  void walk() {
    print("I'm walking");
  }
}

mixin Swimmer {
  void swim() {
    print("I'm swimming");
  }
}

mixin Flyable {
  void fly() {
    print("I'm flying");
  }
}

class Duck with Walker, Swimmer, Flyable {
  void duck() {
    walk();
    swim();
    fly();
    print("");
    print("\t I\n\t\tam\n\t\t\tduck."); // At least no "I am Iron Man"
    print("");
    print("CC @ Duckengers Endgame");
  }
}

void main() {
  Duck d = Duck();
  d.duck();
}
