import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.yellow,
          child: const Icon(Icons.add),
          onPressed: () {
            print("Ouch! Stop it!");
          },
        ),
        body: const Center(
          child: Text("Click it!"),
        ),
      ),
    );
  }
}
