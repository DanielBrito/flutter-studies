class Point {
  const Point(this.x, this.y);

  final int x;
  final int y;

  @override
  String toString() => "Point($x, $y)";

  @override
  bool operator ==(covariant Point other) {
    return x == other.x && y == other.y;
  }

  Point operator +(Point other) {
    return Point(x + other.x, y + other.y);
  }

  Point operator *(int other) {
    return Point(x + other, y + other);
  }
}

main() {
  print(Point(1, 1));

  const list = [Point(1, 2), Point(3, 4)];

  print(list);

  print(Point(0, 0) == Point(0, 0));

  print(Point(1, 1) + Point(2, 0));

  print(Point(2, 2) * 5);
}
