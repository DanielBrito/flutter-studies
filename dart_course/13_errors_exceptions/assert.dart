class PositiveInt {
  PositiveInt(this.value) : assert(value >= 0, "Value cannot be negative");

  final int value;
}

void signIn(String email, String password) {
  assert(email.isNotEmpty);
  assert(password.isNotEmpty);
}

main() {
  final invalidAge = PositiveInt(-1);
  print(invalidAge);

  signIn("", "");
}
