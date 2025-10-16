import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/app_layout/custom_appbar.dart';
import 'package:pandyt_app/pages/home/weather_home.dart';
import 'package:pandyt_app/pages/products/view/product_list_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.cloud_outlined), text: 'Weather'),
                Tab(icon: Icon(Icons.shopping_bag_outlined), text: 'Products'),
              ],
            ),
            Expanded(
              child: TabBarView(children: [WeatherHome(), ProductListScreen()]),
            ),
          ],
        ),
      ),
    );
  }
}
