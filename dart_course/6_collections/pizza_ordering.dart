main() {
  const pizzaPrices = {"margherita": 5.5, "pepperoni": 7.5, "vegetarian": 6.6};

  const order = ["margherita", "pepperoni", "pineapple"];

  var total = 0.0;

  for (var item in order) {
    final price = pizzaPrices[item];

    if (price != null) {
      total += price;
    } else {
      print("$item pizza is not in the menu");
    }
  }

  print("Total: \$$total");
}
