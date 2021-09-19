main() {
  var values = <double>[1, 2, 3, 4];

  print(sum(values));
}

double sum(List<double> list) {
  var result = 0.0;

  for (var value in list) {
    result += value;
  }

  return result;
}
