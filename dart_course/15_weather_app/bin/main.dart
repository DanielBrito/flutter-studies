import 'dart:io';

import 'exception.dart';
import 'weather_api_client.dart';

main(List<String> args) async {
  if (args.length != 1) {
    print("Syntax: dart bin/main.dart <city>");
    return;
  }

  final city = args.first;
  final api = WeatherApiClient();

  try {
    final weather = await api.getWeather(city);
    print(weather);
  } on WeatherException catch (e) {
    print(e);
  } on SocketException catch (_) {
    print("Could not fetch data. Check your connection.");
  } catch (e) {
    print(e);
  }
}
