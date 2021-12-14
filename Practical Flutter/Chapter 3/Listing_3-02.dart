import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Playground",
      home: Scaffold(
        body: Center(
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Child1"),
                Divider(),
                Text("Child2"),
                Divider(),
                Text("Child3"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
