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
  late String lat;
  late String lon;

  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  bool positionStreamStarted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final weatherProv = Provider.of<WeatherProvider>(
        context,
        listen: false,
      ); // ✅ get from context

      final lat = _positionItems.isNotEmpty
          ? _positionItems.last.displayValue.split(',')[0].split(':')[1].trim()
          : '7.431394';
      final lon = _positionItems.isNotEmpty
          ? _positionItems.last.displayValue.split(',')[1].split(':')[1].trim()
          : '81.816455';

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

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    _updatePositionList(_PositionItemType.position, position.toString());
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(_PositionItemType.log, _kPermissionDeniedMessage);

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(_PositionItemType.log, _kPermissionGrantedMessage);
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }
    super.dispose();
  }
}

enum _PositionItemType { log, position }

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
