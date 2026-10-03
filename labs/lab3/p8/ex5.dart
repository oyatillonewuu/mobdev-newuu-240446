abstract base class Shape {
  String shapeName;

  Shape(this.shapeName);

  double area();
  double perimeter();

  void printShapeName() {
    print(shapeName);
  }
}
