import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_window/models/weather_model.dart';

class WeatherService {
  final String apiKey = "e0cc0e065aa8a3209ec75d28d695b97c";
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherModel?> fetchWeatherByCityName(String city) async {
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("-----------------------all good");
      return WeatherModel.fromJson(data);
    } else {
      print(
        '!!!!!!!!!!!!!!!!!!!!!1Failed to fetch weather: ${response.statusCode}',
      );
      return null;
    }
  }
  Future<WeatherModel?> fetchWeatherByZipCode(String zipCode,String countryCode) async {
    final url = Uri.parse('$baseUrl?zip=$zipCode,$countryCode&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("-----------------------all good");
      return WeatherModel.fromJson(data);
    } else {
      print(
        '!!!!!!!!!!!!!!!!!!!!!1Failed to fetch weather: ${response.statusCode}',
      );
      return null;
    }
  }
}
