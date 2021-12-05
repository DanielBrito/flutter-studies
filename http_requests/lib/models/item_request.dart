import 'dart:convert';

import 'package:http/http.dart' as http;

import 'base_request.dart';
import 'item.dart';

class RequestItem implements HTTPRequest<Item> {
  final String url;

  const RequestItem({required this.url});

  @override
  Future<Item> execute() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw http.ClientException("Failed to retrieve data!");
    }

    return _parseJson(response.body);
  }

  Item _parseJson(String response) => Item.fromJson(jsonDecode(response));
}
