import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: PopupMenuButton(
            onSelected: (String result) {
              print(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem(value: "copy", child: Text("Copy")),
              const PopupMenuItem(value: "cut", child: Text("Cut")),
              const PopupMenuItem(value: "paste", child: Text("Paste"))
            ],
          ),
        ),
      ),
    );
  }
}
