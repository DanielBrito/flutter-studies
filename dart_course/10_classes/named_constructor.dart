class Complex {
  const Complex(this.re, this.im);

  const Complex.zero()
      : re = 0,
        im = 0;
  const Complex.identity()
      : re = 1,
        im = 0;
  const Complex.real(this.re) : im = 0;
  const Complex.imaginary(this.im) : re = 0;

  final double re;
  final double im;
}

main() {
  // Some special complex numbers:
  // 0 + i * 0
  final zero = Complex.zero();

  // 1 + i * 0
  final identity = Complex.identity();

  // a + i * 0
  final real = Complex.real(3);

  // 0 + i * b
  final imaginary = Complex.imaginary(4);
}
