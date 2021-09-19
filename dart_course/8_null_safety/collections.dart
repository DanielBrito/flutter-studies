main() {
  const cities = <String?>["London", "Paris", null];

  for (var city in cities) {
    print(city?.toUpperCase());
  }
}
