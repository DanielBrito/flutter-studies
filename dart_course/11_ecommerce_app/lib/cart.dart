import 'package:test/item.dart';
import 'package:test/product.dart';

class Cart {
  final Map<int, Item> _items = {};

  void addProduct(Product product) {
    final item = _items[product.id];

    if (item == null) {
      _items[product.id] = Item(product: product, quantity: 1);
    } else {
      _items[product.id] = Item(product: product, quantity: item.quantity + 1);
    }
  }

  bool get isEmpty => _items.isEmpty;

  double total() => _items.values
      .map((item) => item.price)
      .reduce((acc, element) => acc + element);

  @override
  String toString() {
    if (_items.isEmpty) {
      return "Cart is empty";
    }

    final itemizedList =
        _items.values.map((item) => item.toString()).join("\n");

    return "------\n$itemizedList\nTotal: \$${total()}\n------";
  }
}
