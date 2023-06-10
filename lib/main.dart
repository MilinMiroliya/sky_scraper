import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scraper/provider/weather_provider.dart';
import 'package:sky_scraper/screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
