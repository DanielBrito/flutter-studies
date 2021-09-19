main() {
  String firstName = "Daniel";
  String lastName = "Brito";

  // Interpolation:

  print("My name is " + firstName + " " + lastName);
  print("My name is $firstName $lastName");

  // Raw strings avoid using the scape character:

  print(r'C:\Windows\system32');

  // Multiple lines:

  String textScape = "Multiple lines.\nFirst example.\nEnd.";
  String textQuotes = """
Multiple lines.
First example.
End.
""";

  print(textScape);
  print(textQuotes);

  // String operations:

  String title = "Dart course";

  print(title.toUpperCase());

  String lovePizza = "I love pizza";

  print(lovePizza.contains("pizza"));

  String lovePasta = lovePizza.replaceAll("pizza", "pasta");

  print(lovePasta);
}
