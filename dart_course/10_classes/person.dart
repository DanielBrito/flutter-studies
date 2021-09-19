class Person {
  Person({required this.name, required this.age, required this.height});

  final String name;
  final int age;
  final double height;

  void printDescription() {
    print("My name is $name. I'm $age years old. I'm $height meters tall.");
  }
}

main() {
  final p1 = Person(name: "Daniel", age: 28, height: 1.78);
  final p2 = Person(name: "Brito", age: 29, height: 1.76);

  p1.printDescription();
  p2.printDescription();
}
