// Reference => https://dart.dev/tutorials/language/streams

Future<void> main() async {
  final streamFirst = Stream.fromIterable([1, 2, 3]);
  final streamForEach = Stream.fromIterable([4, 5, 6]);
  final streamMap = Stream.fromIterable([7, 8, 9]);

  final value = await streamFirst.first;
  print(value);

  await streamForEach.forEach((element) => print(element));

  final doubles =
      streamMap.map((value) => value * 2).where((value) => value > 15);

  await doubles.forEach(print);
}
