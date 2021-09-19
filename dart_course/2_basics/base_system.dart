main() {
  int green = 0xFF00FF00; // ARGB (Alpha, Red, Green, BLue)
  int x = 0xF0; // binary: 11110000
  int y = 0x0F; // binary: 00001111

  print(green);
  print((~x).toRadixString(2));
  print((x | y).toRadixString(2));
  print((x ^ y).toRadixString(2));
  print((x & y).toRadixString(2));

  int z = 4; // binary: 100

  print((z >> 1).toRadixString(2)); // 10
  print((z << 2).toRadixString(2)); // 10000

  print((z >> 1).toRadixString(10)); // 2
  print((z << 2).toRadixString(10)); // 16
}
