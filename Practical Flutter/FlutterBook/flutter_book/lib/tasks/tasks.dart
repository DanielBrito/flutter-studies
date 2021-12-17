import "package:flutter/material.dart";

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key) {
    print("## Tasks.constructor");
  }

  @override
  Widget build(BuildContext context) {
    print("## Tasks.build()");

    return const Center(
      child: Text("Tasks"),
    );
  }
}
