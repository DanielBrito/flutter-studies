main() {
  const order = ["margherita", "pepperoni", "pineapple"];

  final total = calculateTotal(order).toStringAsFixed(2);

  print("Total: \$$total");
}

double calculateTotal(List<String> order) {
  const pizzaPrices = {"margherita": 5.5, "pepperoni": 7.5, "vegetarian": 6.6};

  var total = 0.0;

  for (var item in order) {
    final price = pizzaPrices[item];

    if (price != null) {
      total += price;
    }
  }

  return total;
}
