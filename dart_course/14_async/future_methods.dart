Future<String> fetchUserOrder() =>
    Future.delayed(Duration(seconds: 2), () => "Cappuccino");

// Returns the value right away:
Future<String> fetchUserOrder2() => Future.value("Espresso");

Future<String> fetchUserOrder3() => Future.error(Exception("Out of milk"));

main() {
  print("Started...");

  fetchUserOrder()
      .then((order) => print("Order is ready: $order"))
      .catchError((error) => print(error))
      .whenComplete(() => print("Done"));
}
