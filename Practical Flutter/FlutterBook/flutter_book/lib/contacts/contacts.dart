import "package:flutter/material.dart";

class Contacts extends StatelessWidget {
  Contacts({Key? key}) : super(key: key) {
    print("## Contacts.constructor");
  }

  @override
  Widget build(BuildContext context) {
    print("## Contacts.build()");

    return const Center(
      child: Text("Contacts"),
    );
  }
}
