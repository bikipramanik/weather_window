import 'package:flutter/material.dart';
import 'package:weather_window/models/weather_model.dart';

class WeatherReport extends StatelessWidget {
  final WeatherModel weather;//getting the model after calling the API which will be stored as weather 

  const WeatherReport({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade800],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade300,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🏙 City + Country
            Text(
              '${weather.cityName}, ${weather.country}',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),

            // ☁️ Weather Icon
            Image.network(
              'https://openweathermap.org/img/wn/${weather.iconId}@4x.png',
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),

            // 🌡 Temperature and feels-like
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              weather.description.toUpperCase(),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),

            const SizedBox(height: 25),

            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(48, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                children: [
                  _buildWeatherStatRow(
                    icon: Icons.thermostat,
                    label: "Min / Max Temp",
                    value:
                        "${weather.tempMin.toStringAsFixed(1)}° / ${weather.tempMax.toStringAsFixed(1)}°",
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  _buildWeatherStatRow(
                    icon: Icons.water_drop,
                    label: "Humidity",
                    value: "${weather.humidity.toStringAsFixed(0)}%",
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  _buildWeatherStatRow(
                    icon: Icons.air,
                    label: "Wind Speed",
                    value: "${weather.windSpeed.toStringAsFixed(1)} m/s",
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  _buildWeatherStatRow(
                    icon: Icons.cloud,
                    label: "Cloudiness",
                    value: "${weather.cloudiness.toStringAsFixed(0)}%",
                  ),
                  const Divider(color: Colors.white24, height: 20),
                  _buildWeatherStatRow(
                    icon: Icons.compress,
                    label: "Pressure",
                    value: "${weather.pressure.toStringAsFixed(0)} hPa",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherStatRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
