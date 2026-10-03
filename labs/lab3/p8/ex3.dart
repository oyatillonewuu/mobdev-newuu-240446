class Person {
  String name;
  int age;

  new(this.name, this.age);
}

class Student extends Person {
  int studentId;
  double overallGPA;

  new(super.name, super.age, this.studentId, this.overallGPA);
}

void main() {
  Student s = Student("Jack The Master of all Trades", 16, 160666, 4.5);
  print(s.name);
  print(s.age);
  print(s.studentId);
  print(s.overallGPA);
}
