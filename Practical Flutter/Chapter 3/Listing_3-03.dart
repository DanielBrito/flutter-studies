import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Playground",
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Playground!")),
        drawer: Drawer(
          child: Column(
            children: const [
              Text("Item 1"),
              Divider(),
              Text("Item 2"),
              Divider(),
              Text("Item 3"),
            ],
          ),
        ),
        body: Center(
          child: Row(
            children: const [
              Text("Child1"),
              Text("Child2"),
              Text("Child3"),
            ],
          ),
        ),
      ),
    );
  }
}
