main() {
  const person = {"name": "Daniel"};

  if (person["age"] == null) {
    print("age is missing");
  } else {
    print(person["age"]);
  }

  // int x = null; // Error
}
