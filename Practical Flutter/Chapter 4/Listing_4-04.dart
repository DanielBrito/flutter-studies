import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GridView.count(
          padding: const EdgeInsets.all(4.0),
          crossAxisCount: 4,
          childAspectRatio: 1.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: const [
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo()),
            GridTile(child: FlutterLogo())
          ],
        ),
      ),
    );
  }
}
