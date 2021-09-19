class Strings {
  static const welcome = "Welcome";
  static const signIn = "Sign in";

  static String greet(String name) => "Hi, $name";
}

main() {
  print(Strings.welcome);
  print(Strings.signIn);
  print(Strings.greet("Daniel"));
}
