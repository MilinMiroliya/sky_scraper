import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sky_scraper/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Forecast> forecastList = [];
  late WeatherModel weatherModel;
  late String place;
  List days = [];

  getWeatherData() async {
    isLoading = true;
    String baseUrl = "https://yahoo-weather5.p.rapidapi.com/weather";
    String location = "Surat";

    Uri url = Uri.parse("$baseUrl?location=$location");
    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Key": "584670a96amsh3aacfd1bdc09c36p124693jsn795fc8d11be7",
        "X-RapidAPI-Host": "yahoo-weather5.p.rapidapi.com",
      },
    );
    print("Status code :: ${response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 429) {
      weatherModel = WeatherModel.fromJson(json.decode(response.body));
      forecastList.addAll(weatherModel.forecasts!);
      isLoading = false;
    } else {
      Fluttertoast.showToast(
        msg: 'Something Went Wrong..',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      isLoading = false;
    }
    notifyListeners();
  }
}
