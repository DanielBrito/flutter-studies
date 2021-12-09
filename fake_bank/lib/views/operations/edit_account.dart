import "package:flutter/material.dart";

import '../../components/drawer.dart';

import '../../routes/app_routes.dart';

class EditAccountPage extends StatelessWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _username = "";
    String _birthdate = "";
    String _cellphone = "";
    String _email = "";
    String _password = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
      ),
      drawer: const Menu(),
      body: SingleChildScrollView(
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
                onChanged: (value) => _birthdate = value,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  label: Text("Birthdate"),
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                height: 24,
              ),
              TextField(
                onChanged: (value) => _cellphone = value,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  label: Text("Cellphone"),
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                height: 24,
              ),
              TextField(
                onChanged: (value) => _email = value,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text("E-mail"),
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                height: 24,
              ),
              TextField(
                onChanged: (value) => _password = value,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  if (isValidInput(
                      _username, _birthdate, _cellphone, _email, _password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Account created!"),
                        backgroundColor: Colors.green,
                      ),
                    );

                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please, fill out all the fields."),
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
                    child: Text("UPDATE ACCOUNT"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isValidInput(String username, String birthdate, String phone, String email,
    String password) {
  return username.isNotEmpty &&
      birthdate.isNotEmpty &&
      phone.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty;
}
