import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class LoginData {
  String username = "";
  String password = "";
}

class _MyApp extends State<MyApp> {
  final LoginData _loginData = LoginData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? inValue) {
                      if (inValue!.isEmpty) {
                        return "Please enter username";
                      }
                      return null;
                    },
                    onSaved: (String? inValue) {
                      _loginData.username = inValue!;
                    },
                    decoration: const InputDecoration(
                        hintText: "none@none.com",
                        labelText: "Username (eMail address)")),
                TextFormField(
                  obscureText: true,
                  validator: (String? inValue) {
                    if (inValue!.length < 10) {
                      return "Password must be >=10 in length";
                    }
                    return null;
                  },
                  onSaved: (String? inValue) {
                    _loginData.password = inValue!;
                  },
                  decoration: const InputDecoration(
                      hintText: "Password", labelText: "Password"),
                ),
                Container(
                  height: 30,
                ),
                ElevatedButton(
                  child: const Text("Log In!"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      print("Username: ${_loginData.username}");
                      print("Password: ${_loginData.password}");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
