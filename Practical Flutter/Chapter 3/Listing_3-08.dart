import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  var _checkboxValue = false;
  var _switchValue = false;
  var _sliderValue = .3;
  var _radioValue = 1;

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
                Checkbox(
                  value: _checkboxValue,
                  onChanged: (bool? inValue) {
                    setState(() {
                      _checkboxValue = inValue!;
                    });
                  },
                ),
                Switch(
                    value: _switchValue,
                    onChanged: (bool inValue) {
                      setState(() {
                        _switchValue = inValue;
                      });
                    }),
                Slider(
                  min: 0,
                  max: 20,
                  value: _sliderValue,
                  onChanged: (inValue) {
                    setState(() => _sliderValue = inValue);
                  },
                ),
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (int? inValue) {
                          setState(() {
                            _radioValue = inValue!;
                          });
                        }),
                    const Text("Option 1")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: (int? inValue) {
                          setState(() {
                            _radioValue = inValue!;
                          });
                        }),
                    const Text("Option 2")
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 3,
                        groupValue: _radioValue,
                        onChanged: (int? inValue) {
                          setState(() {
                            _radioValue = inValue!;
                          });
                        }),
                    const Text("Option 3")
                  ],
                ),
                Container(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    print("Checkbox: $_checkboxValue");
                    print("Switch: $_switchValue");
                    print("Slider: $_sliderValue");
                    print("Radio: $_radioValue");
                  },
                  child: const Text("Print values"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
