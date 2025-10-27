class WeatherModel {
  final String cityName;
  final String main;
  final String description;
  final String iconId;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final double pressure;
  final double humidity;
  final double seaLevel;
  final double cloudiness;
  final double windSpeed;
  final String country;

  WeatherModel({
    required this.cityName,
    required this.main,
    required this.description,
    required this.iconId,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.cloudiness,
    required this.windSpeed,
    required this.country,
  });


//factory constructor allows me to create a instance without creating a instance just returning the object according to the data we get
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"] ?? '',
      main: json["weather"] != null && json["weather"].isNotEmpty
          ? json["weather"][0]["main"] ?? ''
          : '',
      description: json["weather"] != null && json["weather"].isNotEmpty
          ? json["weather"][0]["description"] ?? ''
          : '',
      iconId: json["weather"] != null && json["weather"].isNotEmpty
          ? json["weather"][0]["icon"] ?? ''
          : '',
      temperature: (json["main"]?["temp"] as num?)?.toDouble() ?? 0.0,
      feelsLike: (json["main"]?["feels_like"] as num?)?.toDouble() ?? 0.0,
      tempMin: (json["main"]?["temp_min"] as num?)?.toDouble() ?? 0.0,
      tempMax: (json["main"]?["temp_max"] as num?)?.toDouble() ?? 0.0,
      pressure: (json["main"]?["pressure"] as num?)?.toDouble() ?? 0.0,
      humidity: (json["main"]?["humidity"] as num?)?.toDouble() ?? 0.0,
      seaLevel: (json["main"]?["sea_level"] as num?)?.toDouble() ?? 0.0,
      cloudiness: (json["clouds"]?["all"] as num?)?.toDouble() ?? 0.0,
      windSpeed: (json["wind"]?["speed"] as num?)?.toDouble() ?? 0.0,
      country: json["sys"]?["country"] ?? '',
    );
  }
}
