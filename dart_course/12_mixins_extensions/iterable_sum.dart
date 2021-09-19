// Useful package => https://pub.dev/packages/dartx

extension IterableX<T extends num> on Iterable<T> {
  T sum() => reduce((acc, element) => (acc + element) as T);
}

void main() {
  final sumInt = [1, 2, 3].sum();
  final sumDouble = [4, 5, 6].sum();

  print(sumInt);
  print(sumDouble);
}
