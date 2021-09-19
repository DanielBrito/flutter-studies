main() {
  int? a; // Nullable
  int b = 2;

  // print(a + b); // Compile-time error

  int x;
  int y = 2;

  // print(x + y); // Run-time error

  // Flow analysis - Promotion:

  if (a == null) {
    print("a is null");
  } else {
    print(a + b);
  }

  // Flow analysis - Definite assignment:

  int v = 10;
  int sign;

  if (v >= 0) {
    sign = 1;
  } else {
    sign = -1;
  }

  // Or:

  sign = v >= 0 ? 1 : -1;

  print(sign);
}
