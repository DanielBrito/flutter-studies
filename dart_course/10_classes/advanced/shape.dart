import "dart:math";

// We can use abstract classes to define an interface.
// It can be implemented by subclasses.
abstract class Shape {
  double get area;
  double get perimeter;

  void printValues() {
    print("area: $area, perimeter: $perimeter");
  }
}

// Using inheritance: a Square Is-A Shape
class Square extends Shape {
  Square(this.side);

  final double side;

  @override
  double get area => side * side;

  @override
  double get perimeter => side * 4;
}

class Circle extends Shape {
  Circle(this.radius);

  final double radius;

  @override
  double get area => pi * radius * radius;

  @override
  double get perimeter => 2 * pi * radius;
}

// Dependency Inversion Principle:
// Code with abstractions, to be independent from specific implementation.
void printArea(Shape shape) {
  print(shape.area);
}

main() {
  final square = Square(10);
  printArea(square);

  final circle = Circle(5);
  printArea(circle);

  final shapes = [Square(3), Circle(4)];

  shapes.forEach((shape) => shape.printValues());
}
