import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Playground",
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Playground")),
        body: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepTapped: (int index) {
            setState(
              () {
                _currentStep = index;
              },
            );
          },
          onStepContinue:
              _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
          onStepCancel:
              _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          steps: const [
            Step(
              title: Text("Get Ready"),
              isActive: true,
              content: Text("Let's begin..."),
            ),
            Step(
              title: Text("Get Set"),
              isActive: true,
              content: Text("Ok, just a little more..."),
            ),
            Step(
              title: Text("Go!"),
              isActive: true,
              content: Text("And, we're done!"),
            ),
          ],
        ),
      ),
    );
  }
}
