// With null safety!
main() {
  const list1 = [1, 2, 3];
  const list2 = [1.0, 2.0, 3.0];

  list1.forEach(print);

  final doubles = transform<int, int>(list1, (x) => x * 2);
  final squares = transform<double, int>(list2, (x) => x.round());

  print(doubles);
  print(squares);
}

List<R> transform<T, R>(List<T> items, R Function(T) f) {
  var result = <R>[];

  for (var x in items) {
    result.add(f(x));
  }

  return result;
}
