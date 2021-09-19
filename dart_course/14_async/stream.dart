// Stream: asynchronous Iterable
// Iterable: synchronous

// Note:
//  The 'yield' adds a value to the output stream of the surrounding async* function.
// It's like return , but doesn't terminate the function.

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;

  await for (var value in stream) {
    sum += value;
  }

  return sum;
}

Future<int> sumStreamReduce(Stream<int> stream) =>
    stream.reduce((acc, element) => acc + element);

Stream<int> countStream(int n) async* {
  for (var i = 1; i <= n; i++) {
    await Future.delayed(Duration(seconds: 1));
    print(i);

    yield i;
  }
}

Iterable<int> count(int n) sync* {
  for (var i = 1; i <= n; i++) {
    yield i;
  }
}

Future<void> main() async {
  final stream = Stream<int>.fromIterable([1, 2, 3, 4]);
  final sum = await sumStream(stream);

  print("Sum: $sum");

  final stream2 = Stream<int>.fromIterable([5, 6, 7, 8]);
  final sum2 = await sumStreamReduce(stream2);

  print("Sum: $sum2");

  final stream3 = countStream(5);
  final sum3 = await sumStream(stream3);

  print("Sum: $sum3");

  final iterable = count(10);
  print(iterable);
}
