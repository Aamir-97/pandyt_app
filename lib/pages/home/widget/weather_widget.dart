import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/home/models/open_weather_api/open_weather_model.dart';

class WeatherWidget extends StatelessWidget {
  final OpenWeatherModel weather;
  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '${weather.main!.temp!.toStringAsFixed(1)}°C',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            weather.weather!.isNotEmpty
                ? weather.weather![0].description!
                : 'No description',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
