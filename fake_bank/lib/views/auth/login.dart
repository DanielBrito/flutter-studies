import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fake Bank"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: Image.asset("assets/fake_bank_logo.png"),
                ),
                Container(
                  height: 30,
                ),
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
                  onChanged: (value) => _password = value,
                  keyboardType: TextInputType.text,
                  obscureText: true,
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
                    if (isValidUser(_username, _password)) {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.mainMenu);
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
                      child: Text("ENTER"),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                ),
                RichText(
                  text: TextSpan(
                    text: "Create new account",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.newAccount),
                          },
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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

bool isValidUser(String username, String password) {
  return username.isNotEmpty && password.isNotEmpty;
}
