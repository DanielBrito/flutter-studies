import "package:flutter/material.dart";

import '../components/drawer.dart';

import '../routes/app_routes.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({Key? key}) : super(key: key);

  @override
  _MainMenuPageState createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
      ),
      drawer: const Menu(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Available services:",
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.balance),
              child: SizedBox(
                height: 110,
                width: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 50,
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text("CHECK BALANCE"),
                  ],
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.transaction),
              child: SizedBox(
                height: 110,
                width: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                      size: 50,
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text("BANK TRANSFER"),
                  ],
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.editAccount),
              child: SizedBox(
                height: 110,
                width: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.mode_edit,
                      color: Colors.white,
                      size: 50,
                    ),
                    Container(
                      height: 10,
                    ),
                    const Text("EDIT ACCOUNT"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
