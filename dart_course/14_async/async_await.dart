Future<String> fetchUserOrder() =>
    Future.delayed(Duration(seconds: 2), () => "Cappuccino");

Future<void> main() async {
  print("Started...");

  final order = await fetchUserOrder();

  print(order);
}
