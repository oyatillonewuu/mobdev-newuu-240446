class Person {
  String name;
  int age;

  static int _getValidatedAge(int age) {
    if (age <= 0) {
      throw 'Panic: age is not non-negative.';
    }
    return age;
  }

  static String _getValidatedName(String name) {
    if (name.isEmpty) {
      throw 'Panic: name is empty.';
    }
    return name;
  }

  new(String name, int age)
    : name = _getValidatedName(name),
      age = _getValidatedAge(age);
}

void main() {
  var p = Person("loga4m", 20);
}
