import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Chip(
            avatar: const CircleAvatar(
              backgroundImage: AssetImage("assets/img/user.png"),
            ),
            backgroundColor: Colors.grey.shade300,
            label: const Text("Daniel Brito"),
          ),
        ),
      ),
    );
  }
}
