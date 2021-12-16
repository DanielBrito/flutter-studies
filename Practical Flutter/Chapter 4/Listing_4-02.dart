import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(height: 100),
            Table(
              border: const TableBorder(
                top: BorderSide(width: 2),
                bottom: BorderSide(width: 2),
                left: BorderSide(width: 2),
                right: BorderSide(width: 2),
              ),
              children: const [
                TableRow(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("1"),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("2"),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("3"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
