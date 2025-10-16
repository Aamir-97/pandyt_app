import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/home/models/open_weather_api/open_weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  OpenWeatherModel? _weatherModel;

  OpenWeatherModel? get weatherModel => _weatherModel;

  void setWeatherModel(OpenWeatherModel model) {
    _weatherModel = model;
    notifyListeners();
  }

  void clearWeatherModel() {
    _weatherModel = null;
    notifyListeners();
  }
}
