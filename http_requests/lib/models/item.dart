class Item {
  final int id;
  final String title;

  Item({required this.id, required this.title});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}
