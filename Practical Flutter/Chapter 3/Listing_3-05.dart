import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Flutter Playground"),
              bottom: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.announcement),
                ),
                Tab(
                  icon: Icon(Icons.cake),
                ),
                Tab(
                  icon: Icon(Icons.cloud),
                )
              ])),
          body: const TabBarView(
            children: [
              Center(
                child: Text("Announcements"),
              ),
              Center(
                child: Text("Birthdays"),
              ),
              Center(
                child: Text("Data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
