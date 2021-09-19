main() {
  const list = [1, 2, 3];

  list.forEach(print);

  final doubles = list.map((e) => e * 2);

  print(doubles);
}
