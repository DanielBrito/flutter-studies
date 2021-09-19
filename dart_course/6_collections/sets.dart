main() {
  // Declaration:

  var euCountries = {"Italy", "UK", "Russia"};
  var asianCountries = {"India", "China", "Russia"};

  print(euCountries.elementAt(0));

  euCountries.remove("UK");
  euCountries.add("Belgium");

  print(euCountries);

  print(euCountries.first);
  print(euCountries.last);
  print(euCountries.length);

  // Operations:

  print(euCountries.union(asianCountries));
  print(euCountries.intersection(asianCountries));
  print(euCountries.difference(asianCountries));

  // Iterating:

  for (var country in euCountries) {
    print(country);
  }
}
