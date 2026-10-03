import "dart:math";

abstract class Shape {
  double area();
}

class Circle extends Shape {
  double radius;

  new(this.radius);

  @override
  double area() {
    return pi * pow(radius, 2);
  }
}

class Rectangle extends Shape {
  double base;
  double height;

  new({required this.base, required this.height});

  @override
  double area() {
    return base * height;
  }
}

void main() {
  List<Shape> shapes = [
    Circle(4.0),
    Circle(6.6),
    Rectangle(base: 2.0, height: 5.0),
    Rectangle(base: 3.0, height: 6.0),
  ];

  for (Shape shape in shapes) {
    print("Type: ${shape.runtimeType.toString()}");
    print("Area: ${shape.area()}");
  }
}
