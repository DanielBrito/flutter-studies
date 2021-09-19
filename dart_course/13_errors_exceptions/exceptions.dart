class Fraction {
  Fraction(this.numerator, this.denominator) {
    if (denominator == 0) {
      throw IntegerDivisionByZeroException();
    }
  }

  final int numerator;
  final int denominator;

  double get value => numerator / denominator;
}

void testFraction() {
  try {
    final f = Fraction(3, 0);
    print(f.value);
  } on IntegerDivisionByZeroException catch (e) {
    print(e);
  } on Exception catch (e) {
    print(e);
  } finally {
    print("testFraction done");
  }
}

main() {
  final f1 = Fraction(6, 3);
  print(f1.value);

  final f2 = Fraction(3, 1);
  print(f2.value);

  testFraction();
}
