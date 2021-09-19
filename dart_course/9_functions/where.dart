main() {
  const list = [1, 2, 3, 4];

  // Similar to filter() in JavaScript:
  final even = list.where((element) => element % 2 == 0);

  print(even);

  final value = list.firstWhere((element) => element == 3, orElse: () => -1);

  print(value);
}
