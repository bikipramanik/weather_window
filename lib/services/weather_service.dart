import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_window/models/weather_model.dart';

//a class which will responsible for call the API
class WeatherService {
  //the actual API key for this service
  final String apiKey = "e0cc0e065aa8a3209ec75d28d695b97c";
  //base url
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherModel?> fetchWeatherByCityName(String city) async {
    //fetching weather using city name

    //the complete url for fetching weather using city name
    final url = Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric');

    // storing the response after calling the http.get with the url
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //if it has no error
      //now we got the data as json so we are decoding response body as json decode
      final data = json.decode(response.body);
      print("-----------------------all good");
      //we are converting returing the data as a WeatherModel class
      return WeatherModel.fromJson(data);
    } else {
      //if we have something error
      print(
        '!!!!!!!!!!!!!!!!!!!!!1Failed to fetch weather: ${response.statusCode}',
      );
      return null;
    }
  }

  //fetching weather using zip mode
  Future<WeatherModel?> fetchWeatherByZipCode(
    String zipCode,
    String countryCode,
  ) async {
    final url = Uri.parse(
      '$baseUrl?zip=$zipCode,$countryCode&appid=$apiKey&units=metric',
    );
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
