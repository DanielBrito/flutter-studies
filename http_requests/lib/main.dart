import 'package:flutter/material.dart';

import 'models/item_request.dart';
import 'widgets/request_page.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const url = "https://jsonplaceholder.typicode.com/posts/10";
    const request = RequestItem(url: url);

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Request Demo"),
            ),
            body: const Center(
              child: HTTPWidget(request: request),
            )));
  }
}
