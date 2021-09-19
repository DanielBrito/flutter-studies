class Person {
  Person({required this.name, required this.age});

  final String name;
  final int age;

  factory Person.fromJson(Map<String, Object> json) {
    final name = json["name"];
    final age = json["age"];

    if (name is String && age is int) {
      return Person(name: name, age: age);
    }

    throw StateError("could not read name or age");
  }

  Map<String, Object> toJson() => {
        "name": name,
        "age": age,
      };
}

main() {
  final person = Person.fromJson({
    "name": "Daniel",
    "age": 36,
  });

  print(person); // Instance of Person

  final json = person.toJson();

  print(json);
}
