main() {
  print(describePositional("Daniel", 28));
  print(describeNamed(name: "Daniel"));
  print(describeNullable(name: "Daniel"));
  print(describeRequired(name: "Daniel", age: 28));
  foo(1);
  bar(1, b: 2, c: 3);
}

// Using positional parameters:
String describePositional(String name, int age) {
  return "My name is $name and I'm $age years old.";
}

// Using named arguments with default values:
String describeNamed({String name = "", int age = 0}) {
  return "My name is $name and I'm $age years old.";
}

// Nullable approach:
String describeNullable({String? name, int? age}) {
  return "My name is $name and I'm $age years old.";
}

// Required approach (best):
String describeRequired({required String name, required int age}) {
  return "My name is $name and I'm $age years old.";
}

// The value of b is optional:
void foo(int a, [int b = 2]) {
  print("a: $a, b: $b");
}

void bar(int a, {int? b, int? c}) {
  print("a: $a, b: $b, c: $c");
}
