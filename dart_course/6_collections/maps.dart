main() {
  var person = <String, dynamic>{"name": "Daniel", "age": 28, "height": 1.76};

  // Access with subscript operator:
  print(person["name"]);

  // Updating:
  person["age"] = 29;

  // Creating new field:
  person["likesProgramming"] = true;

  print(person);

  // Gives access to String operations (as operator):
  var name = person["name"] as String;

  print(name.toUpperCase());

  // Not existing field:
  var weight = person["weight"];

  print(weight); // null

  // Iterating keys:
  for (var key in person.keys) {
    print(key);
  }

  // Iterating values:
  for (var key in person.keys) {
    print(person[key]);
  }

  for (var value in person.values) {
    print(value);
  }

  // Iterating entries:
  for (var entry in person.entries) {
    print("${entry.key}: ${entry.value}");
  }
}
