import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Playground",
      home: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            const Center(
              child: Opacity(
                opacity: .25,
                child: Text("Faded"),
              ),
            ),
            const Spacer(),
            Center(
              child: Theme(
                data: ThemeData(
                  colorScheme:
                      ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
                ),
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    "Text with a background color",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF000000), Color(0xFFFF0000)],
                      tileMode: TileMode.repeated),
                ),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Text(
                    "Hello",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Container(
                color: Colors.yellow,
                child: Transform(
                  alignment: Alignment.bottomLeft,
                  transform: Matrix4.skewY(0.4)..rotateZ(-3 / 12.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    color: Colors.red,
                    child: const Text("Eat at Joe's!"),
                  ),
                ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
