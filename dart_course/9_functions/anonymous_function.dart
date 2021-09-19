main() {
  final sayHi = (String name) => "Hi, $name";

  print(sayHi("Daniel"));
  welcome(sayHi, "Brito");
}

// High Order Functions or Functions as first-class objects:
void welcome(String Function(String) greet, String name) {
  print(greet(name));
  print("Welcome to this course");
}
