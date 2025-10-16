import 'dart:convert';

import 'package:pandyt_app/api/api_repository.dart';
import 'package:pandyt_app/pages/home/models/open_weather_api/open_weather_model.dart';

class WeatherService {
  final ApiRepository _apiRepository = ApiRepository();

  Future<OpenWeatherModel?> fetchWeather({
    required String lat,
    required String lon,
  }) async {
    print('Fetching weather for lat: $lat, lon: $lon');
    final String apiKey =
        'b0ef2e343b7619893ed4075fb79f3ea1'; // Replace with your actual API key
    try {
      final response = await _apiRepository.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
      );
      print('Weather API response: $response');
      return OpenWeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      // Handle errors
      print('Error fetching weather: $e');
      return null;
    }
  }
}
