class EmailAddress {
  EmailAddress(this.email) {
    if (email.isEmpty) {
      throw FormatException("Email can't be empty");
    }

    if (!email.contains("@")) {
      throw FormatException("$email doesn't contain the @ symbol");
    }
  }

  final String email;

  @override
  String toString() => email;
}

main() {
  try {
    print(EmailAddress("me@example.com"));
    print(EmailAddress("example.com"));
    print(EmailAddress(""));
  } on FormatException catch (e) {
    print(e);
  }
}
