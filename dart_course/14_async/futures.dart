Future<String> fetchUserOrder() =>
    Future.delayed(Duration(seconds: 2), () => "Cappuccino");

main() {
  print("Started...");

  fetchUserOrder()
      .then((order) => print("Order is ready: $order"))
      .catchError((error) => print(error))
      .whenComplete(() => print("Done"));
}
