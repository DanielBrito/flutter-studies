// Best practice:
// If you need copy-behaviour in your immutable classes, create a copyWith method.

// Convient:
// Set the properties that you want, omit the others (via named arguments).

class Credentials {
  const Credentials({this.email = "", this.password = ""});

  final String email;
  final String password;

  Credentials copyWith({String? email, String? password}) {
    return Credentials(
        email: email ?? this.email, password: password ?? this.password);
  }

  @override
  String toString() => "Credentials($email, $password)";
}

main() {
  const credentials = Credentials();

  final update1 = credentials.copyWith(email: "me@email.com");
  print(update1);

  final update2 = credentials.copyWith(password: "123456");
  print(update2);
}
