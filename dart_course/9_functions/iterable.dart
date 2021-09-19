main() {
  const list = [1, 2, 3];

  list.forEach(print);

  // Because map returns an iterable:
  final List<int> doubles = list.map((e) => e * 2).toList();

  print(doubles);
}
