import "dart:math";

// We can use abstract classes to define an interface.
// It can be implemented by subclasses.
abstract class Shape {
  double get area;

  const Shape();

  factory Shape.fromJson(Map<String, Object> json) {
    final type = json["type"];

    switch (type) {
      case "square":
        final side = json["side"];
        if (side is double) {
          return Square(side);
        }
        throw UnsupportedError("invalid or missing side property");
      case "circle":
        final radius = json["radius"];
        if (radius is double) {
          return Circle(radius);
        }
        throw UnsupportedError("invalid or missing radius property");
      default:
        throw UnimplementedError("shape $type not recognized");
    }
  }
}

// Using inheritance: a Square Is-A Shape
class Square extends Shape {
  Square(this.side);

  final double side;

  @override
  double get area => side * side;
}

class Circle extends Shape {
  Circle(this.radius);

  final double radius;

  @override
  double get area => pi * radius * radius;
}

// Dependency Inversion Principle:
// Code with abstractions, to be independent from specific implementation.
void printArea(Shape shape) {
  print(shape.area);
}

main() {
  final shapesJson = [
    {"type": "square", "side": 10.0},
    {"type": "circle", "radius": 5.0},
  ];

  final shapes = shapesJson.map((shapeJson) => Shape.fromJson(shapeJson));

  shapes.forEach(printArea);
}
