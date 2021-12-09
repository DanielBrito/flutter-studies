import "package:flutter/material.dart";

import "../../components/drawer.dart";

class BalancePage extends StatelessWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Balance"),
      ),
      drawer: const Menu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Image.asset("assets/success.png"),
          ),
          Container(
            height: 30,
          ),
          const Text(
            "Your balance:",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Container(
            height: 10,
          ),
          const Text(
            r"R$ 10.000",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 40),
          ),
        ],
      ),
    );
  }
}
