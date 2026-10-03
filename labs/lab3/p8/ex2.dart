abstract class Animal {
  makeSound() {
    print("woo!");
  }
}

class Dog extends Animal {
  @override
  makeSound() {
    print("Woof!");
  }
}

void main() {
  Dog d = Dog();
  d.makeSound();
}
