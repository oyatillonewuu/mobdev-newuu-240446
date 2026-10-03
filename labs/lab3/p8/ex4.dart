abstract class Shape {
  double area();
  double perimeter();
}

abstract class Polygon extends Shape {}

class Triangle extends Polygon {
  double a;
  double b;
  double c;

  new(this.a, this.b, this.c);

  @override
  double area() {
    throw UnimplementedError;
  }

  @override
  double perimeter() {
    return a + b + c;
  }
}

void main() {
  Triangle t = Triangle(3.4, 5.6, 7.8);
  print(t.area());
  print(t.perimeter());
}
