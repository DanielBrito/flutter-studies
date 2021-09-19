typedef Greet = String Function(String);

String sayHi(String name) => "Hi, $name";
String sayBonjour(String name) => "Bonjour, $name";
String sayHola(String name) => "Hola, $name";

main() {
  print(sayHi("Daniel"));
  welcome(sayBonjour, "Brito");
}

void welcome(Greet greet, String name) {
  print(greet(name));
  print("Welcome to this course");
}
