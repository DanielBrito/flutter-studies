import "package:flutter/material.dart";

import "../../components/drawer.dart";

import '../../routes/app_routes.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _username = "";
    double _amount = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      drawer: const Menu(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => _username = value,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text("Username"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 24,
                ),
                TextField(
                  onChanged: (value) => _amount = double.parse(value),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    border: OutlineInputBorder(),
                  ),
                ),
                Container(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isValidInput(_username, _amount)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Successful transaction!"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.mainMenu);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please, fill out the fields correctly."),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("CONFIRM TRANSACTION"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool isValidInput(String username, double amount) {
  print("$username - $amount");

  return username.isNotEmpty && amount > 0;
}
