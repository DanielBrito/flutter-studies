import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: Home()));
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future _showIt() async {
      switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("What's your favorite food?"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "broccoli");
                },
                child: const Text("Broccoli"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "pasta");
                },
                child: const Text(
                  "Pasta",
                ),
              )
            ],
          );
        },
      )) {
        case "broccoli":
          print("Broccoli");
          break;
        case "pasta":
          print("Pasta");
          break;
      }
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(child: const Text("Show it"), onPressed: _showIt),
      ),
    );
  }
}
