main() {
  // Declaration:

  var cities = ["London", "Paris", "New York"];
  print(cities[1]);

  // Updating:

  cities[1] = "Moscow";
  print(cities[1]);

  // Iterating:

  for (var city in cities) {
    print(city);
  }

  for (var i = 0; i < cities.length; i++) {
    print(cities[i]);
  }

  // Methods:

  print([].isEmpty); // true
  print(cities.isNotEmpty); // true

  print(cities.first); // London
  print(cities.last); // New York

  cities.add("Tokyo");
  cities.insert(0, "São Paulo");

  print(cities.first); // São Paulo

  cities.removeAt(0);

  print(cities.contains("São Paulo")); // false
  print(cities.indexOf("Moscow")); // 1
}
