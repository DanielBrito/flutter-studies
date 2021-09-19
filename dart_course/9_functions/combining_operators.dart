main() {
  const emails = [
    "abc@abc.com",
    "me@example.com",
    "john@gmail.com",
    "katty@yahoo.com"
  ];

  const knownDomains = ["gmail.com", "yahoo.com"];

  final unknownDomais = getUnknownDomains(emails, knownDomains);

  print(unknownDomais);
}

Iterable<String> getUnknownDomains(
        List<String> emails, List<String> knownDomains) =>
    emails
        .map((email) => email.split("@").last)
        .where((domain) => !knownDomains.contains(domain));
