class Person {
  String name;
  int age;

  new(this.name, this.age);

  void printInfo() {
    print("Name: ${this.name}");
    print("Age: ${this.age}");
  }
}

void main() {
  var p = Person("Oyatillo", 20);
  p.printInfo();
}
