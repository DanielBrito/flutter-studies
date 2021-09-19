class Complex {
  // Best practice - const constructor for final attributes:
  const Complex(this.re, this.im); // Default constructor

  final double re;
  final double im;
}

main() {
  const complex = Complex(1, 2);
  print(complex);
}
