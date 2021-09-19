enum Medal { gold, silver, bronze, noModal }

main() {
  const medal = Medal.gold;

  switch (medal) {
    case Medal.gold:
      print("Gold");
      break;
    case Medal.silver:
      print("Silver");
      break;
    case Medal.bronze:
      print("Bronze");
      break;
    default:
      print("No medal");
  }
}
