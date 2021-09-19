main() {
  final list = [1, 2, 3];
  final copy1 = list; // Points to the same location

  copy1[0] = 0;

  final copy2 = [...list]; // Real copy stored in new location

  copy2[2] = 4;

  print("list: $list");
  print("copy1: $copy1");
  print("copy2: $copy2");
}
