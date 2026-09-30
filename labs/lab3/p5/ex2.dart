abstract base class Shape {
  String? name;

  new(this.name);

  double area();
  double perimeter();
}

base class Rectangle extends Shape {
  double a;
  double b;

  new(this.a, this.b, {String? name}) : super(name);

  @override
  double area() {
    // Multiply a * b to get area for any rectangle
    return this.a * this.b;
  }

  @override
  double perimeter() {
    /* Perimeter -- sum of all sides.
      Add a and b and multiply the sum by 2 to get
      perimeter.
    */
    return 2 * (this.a + this.b);
  }
}

void main() {
  Rectangle rect = Rectangle(4, 5);

  print("Sides: ${rect.a}, ${rect.b}");
  print("Area: ${rect.area()}");
  print("Perimeter: ${rect.perimeter()}");
}
