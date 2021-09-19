main() {
  double tempFarenheit = 90;
  double tempCelsius = (tempFarenheit - 32) / 1.8;

  print(
      "${tempFarenheit.toStringAsFixed(1)}F = ${tempCelsius.toStringAsFixed(1)}C");
}
