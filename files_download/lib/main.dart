import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/download_widget.dart';
import 'models/progress.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatelessWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DownloadProgress>(
      create: (_) => DownloadProgress(),
      child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: const Text("Download Demo"),
              ),
              body: const Center(
                child: DownloadWidget(),
              ))),
    );
  }
}
