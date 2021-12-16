import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(height: 100),
            DataTable(
              sortColumnIndex: 1,
              columns: const [
                DataColumn(
                  label: Text("First Name"),
                ),
                DataColumn(
                  label: Text("Last Name"),
                ),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(
                      Text("Leia"),
                    ),
                    DataCell(Text("Morgana"), showEditIcon: true),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Luke")),
                    DataCell(
                      Text("Skywalker"),
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("Han")),
                    DataCell(
                      Text("Solo"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
