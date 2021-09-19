main() {
  int x = 42;
  int? maybeValue;

  if (x > 0) {
    maybeValue = x;
  }

  // Assertion operation (certain that value != null):
  int value = maybeValue!;

  print(value);

  // If-null operation:
  int y = -1;
  int? expectedValue;

  if (y > 0) {
    expectedValue = y;
  }

  // Augmented assignment if-null operator:
  expectedValue ??= 0;

  // Use when we have a default (or fallback) value:
  int newValue = expectedValue;

  print(newValue);
}
