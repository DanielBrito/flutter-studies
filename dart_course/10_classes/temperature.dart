class Temperature {
  Temperature.celsius(this.celsius);
  Temperature.farenheit(double farenheit) : celsius = (farenheit - 32) / 1.8;

  double celsius;

  double get farenheit => celsius * 1.8 + 32;
  set farenheit(double farenheit) => celsius = (farenheit - 32) / 1.8;
}

main() {
  final temp1 = Temperature.celsius(30);
  final temp2 = Temperature.farenheit(90);

  print(temp1.celsius);

  temp1.celsius = 32;

  // Using the get method:
  print(temp1.farenheit);

  temp1.farenheit = 90;
}
