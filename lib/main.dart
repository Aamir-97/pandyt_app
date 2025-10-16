import 'package:flutter/material.dart';
import 'package:pandyt_app/pages/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pandyt_app/pages/home/providers/weather_provider.dart';
import 'package:pandyt_app/pages/todo_list/provider/todo_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider()),
        ChangeNotifierProvider(create: (context) => TodoListProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const Home(),
      ),
    );
  }
}
