main() {
  const list = [1, 2, 3];

  list.forEach((element) => print(element));

  list.forEach(print);

  for (var value in list) {
    print(value);
  }
}
