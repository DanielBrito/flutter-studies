import 'package:flutter/material.dart';
import 'package:http_requests/models/base_request.dart';
import 'package:http_requests/models/item.dart';

import 'error_widget.dart';
import 'success_widget.dart';

class HTTPWidget extends StatefulWidget {
  final HTTPRequest<Item> request;

  const HTTPWidget({Key? key, required this.request}) : super(key: key);

  @override
  _HTTPWidgetState createState() => _HTTPWidgetState();
}

class _HTTPWidgetState extends State<HTTPWidget> {
  late final Future<Item> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = widget.request.execute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureItems,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorItemWidget();
          }

          if (snapshot.hasData) {
            return SuccessItemWidget(data: snapshot.data as Item);
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
