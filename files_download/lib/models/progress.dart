import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProgress with ChangeNotifier {
  double get progress => _progress;

  void start({required String url, required String localPath}) async {
    // Reset in case it isn't at zero
    _resetProgress();

    // Path and name
    final directory = await getTemporaryDirectory();
    final fileName = "${directory.path}/$localPath";

    // Device File Explorer: data/data/com.example.files_download/cache/myFile.pdf
    // print(fileName);

    // Download the file
    await Dio().download(url, fileName,
        options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
        onReceiveProgress: (received, total) {
      if (total != -1) {
        var pos = received / total * 100;
        _updateProgress(pos);
      }
    });
  }

  double _progress = 0;

  void _resetProgress() {
    if (progress != 0) {
      _progress = 0;
      notifyListeners();
    }
  }

  void _updateProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}
