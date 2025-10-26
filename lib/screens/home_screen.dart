import 'package:flutter/material.dart';
import 'package:weather_window/models/weather_model.dart';
import 'package:weather_window/services/weather_service.dart';
import 'package:weather_window/widgets/search_button.dart';
import 'package:weather_window/widgets/search_by_city.dart';
import 'package:weather_window/widgets/search_by_zip.dart';
import 'package:weather_window/widgets/weather_report.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool zipMode = false;

  String cityName = "";
  String zipCode = "";
  String countryCode = "";

  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weatherData;
  bool _isLoading = false;

  void updateCity(String newCity) {
    cityName = newCity;
  }

  void updateZip(String newZipCode, String newCountryCode) {
    zipCode = newZipCode;
    countryCode = newCountryCode;
  }

  Future<void> searchWeather() async {
    if (!zipMode && cityName.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter city name")));
      return;
    } else if (zipMode && (zipCode.isEmpty || countryCode.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all required fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    WeatherModel? result;

    if (zipMode) {
      result = await _weatherService.fetchWeatherByZipCode(
        zipCode,
        countryCode,
      );
    } else {
      result = await _weatherService.fetchWeatherByCityName(cityName);
    }

    setState(() {
      _weatherData = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Weather Window"),
        actions: [
          IconButton(
            onPressed: () => setState(() => zipMode = !zipMode),
            icon: zipMode
                ? const Icon(Icons.location_city_rounded)
                : const Icon(Icons.numbers),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          zipMode
              ? SearchByZip(onZipChanged: updateZip)
              : SearchByCity(onCityChanged: updateCity),

          const SizedBox(height: 10),

          SearchButton(onSearchPressed: searchWeather),

          const SizedBox(height: 20),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_weatherData != null)
            WeatherReport(weather: _weatherData!)
          else
            const Center(
              child: Text("Enter a city or zip code to get started"),
            ),
        ],
      ),
    );
  }
}
