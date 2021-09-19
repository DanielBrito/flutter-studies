main() {
  List miscelanea = [1, "Daniel", true];

  List<String> cities = ["London", "Paris", "Moscow"];

  // Using type annotation (optional):
  var countries = <String>["Brazil", "Mexico", "Cuba"];

  final states = ["São Paulo", "Ceará", "Brasília"];

  // Final variables can't be re-assigned:
  // states = ["Pernambuco"]; // Error

  // But you can still modify their contents:
  states[1] = "Pernanbuco";

  // Doesn't allow change:
  const oceans = ["Pacific", "Atlantic", "Indian"];

  oceans[1] = "Artic"; // Run-time error
}
