import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var _currentPage = 0;

  final _pages = [
    const Text("Page 1 - Announcements"),
    const Text("Page 2 - Birthdays"),
    const Text("Page 3 - Data"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Playground",
      home: Scaffold(
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.announcement), label: "Announcements"),
            BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Birthdays"),
            BottomNavigationBarItem(icon: Icon(Icons.cloud), label: "Data"),
          ],
          currentIndex: _currentPage,
          fixedColor: Colors.red,
          onTap: (int inIndex) {
            setState(
              () {
                _currentPage = inIndex;
              },
            );
          },
        ),
      ),
    );
  }
}
