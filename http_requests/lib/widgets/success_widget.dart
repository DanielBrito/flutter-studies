import 'package:flutter/material.dart';

import '../models/item.dart';

class SuccessItemWidget extends StatelessWidget {
  final Item? data;

  const SuccessItemWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Text("${data!.id} - ${data!.title}");
    } else {
      return const Text("No data to show");
    }
  }
}
