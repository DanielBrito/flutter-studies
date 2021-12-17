import "package:flutter/material.dart";

class Appointments extends StatelessWidget {
  Appointments({Key? key}) : super(key: key) {
    print("## Appointments.constructor");
  }

  @override
  Widget build(BuildContext context) {
    print("## Appointments.build()");

    return const Center(
      child: Text("Appointments"),
    );
  }
}
