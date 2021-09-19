extension Range on int {
  List<int> rangeTo(int other) {
    if (other < this) {
      return [];
    }

    var list = [this];

    for (var i = this + 1; i <= other; i++) {
      list.add(i);
    }

    return list;
  }
}

main() {
  for (var i in 1.rangeTo(5)) {
    print(i);
  }
}
