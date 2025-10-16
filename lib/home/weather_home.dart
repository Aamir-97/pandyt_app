import 'package:flutter/material.dart';
import 'package:pandyt_app/app_layout/custom_appbar.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Column(children: []),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
