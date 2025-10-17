import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pandyt_app/pages/home/providers/weather_provider.dart';
import 'package:pandyt_app/pages/home/services/weather_service.dart';
import 'package:pandyt_app/pages/todo_list/view/todo_add_popup.dart';
import 'package:pandyt_app/pages/todo_list/view/todo_list_view.dart';
import 'package:provider/provider.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  WeatherProvider weatherProvider = WeatherProvider();
  WeatherService weatherService = WeatherService();
  Position? _currentPosition;

  // static const String _kLocationServicesDisabledMessage =
  //     'Location services are disabled.';
  // static const String _kPermissionDeniedMessage = 'Permission denied.';
  // static const String _kPermissionDeniedForeverMessage =
  //     'Permission denied forever.';
  // static const String _kPermissionGrantedMessage = 'Permission granted.';

  late String lat;
  late String lon;

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final weatherProv = Provider.of<WeatherProvider>(
        context,
        listen: false,
      ); // ✅ get from context
      _currentPosition = await _getCurrentPosition();

      final lat = _currentPosition?.latitude.toString() ?? '7.431394';
      final lon = _currentPosition?.longitude.toString() ?? '81.816455';

      final weather = await weatherService.fetchWeather(lat: lat, lon: lon);
      if (weather != null) {
        weatherProv.setWeatherModel(weather);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<WeatherProvider>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: value.weatherModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '${value.weatherModel!.name}',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${value.weatherModel!.main!.temp!.toStringAsFixed(1)}°C',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              value.weatherModel!.weather!.isNotEmpty
                                  ? value.weatherModel!.weather![0].description!
                                  : 'No description',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Text(
                      'To-Do List',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // This part is scrollable
                    Expanded(
                      child: TodoListView(), // ListView is scrollable by itself
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          showTodoAddPopup(context);
        },
        child: Icon(Icons.add, size: 26, weight: 800),
      ),
    );
  }

  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return null;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
