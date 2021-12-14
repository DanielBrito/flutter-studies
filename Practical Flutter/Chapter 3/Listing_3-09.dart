import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Scaffold(body: Home()));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }

    print(selectedDate);
  }

  Future<void> _selectTime(inContext) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: inContext,
      initialTime: TimeOfDay.now(),
    );

    print(selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(height: 50),
          ElevatedButton(
              child: const Text("Test DatePicker"),
              onPressed: () => _selectDate(context)),
          ElevatedButton(
              child: const Text("Test TimePicker"),
              onPressed: () => _selectTime(context))
        ],
      ),
    );
  }
}
