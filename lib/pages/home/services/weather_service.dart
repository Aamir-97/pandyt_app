import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pandyt_app/api/api_repository.dart';
import 'package:pandyt_app/pages/home/models/open_weather_api/open_weather_model.dart';

class WeatherService {
  final ApiRepository _apiRepository = ApiRepository();

  Future<OpenWeatherModel?> fetchWeather({
    required String lat,
    required String lon,
  }) async {
    final String apiKey =
        dotenv.env['OPENWEATHER_API_KEY'] ??
        ''; // Replace with your actual API key
    try {
      final response = await _apiRepository.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
      );
      return OpenWeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      // Handle errors
      return null;
    }
  }
}
