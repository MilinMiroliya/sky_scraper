import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sky_scraper/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Forecast> forecastList = [];
  List<Location> locationList = [];
  List<CurrentObservation> currentObservationList = [];
  late WeatherModel weatherModel;
  late String place;
  List days = [];
  bool isSearch = false;
  String city = "surat";

  toSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }

  changeLocation(String nameOfCity) {
    city = nameOfCity;
    print("${city[0].toUpperCase()} ");
    getWeatherData();
    isSearch = !isSearch;
    notifyListeners();
  }

  getWeatherData() async {
    isLoading = true;
    String baseUrl = "https://yahoo-weather5.p.rapidapi.com/weather";
    String location = city;

    Uri url = Uri.parse("$baseUrl?location=$location");
    var response = await http.get(
      url,
      headers: {
        "X-RapidAPI-Key": "ed0f1adeb9msh3b48f5d06eaca4ap1ef4edjsn82167cbc18b7",
        "X-RapidAPI-Host": "yahoo-weather5.p.rapidapi.com",
      },
    );
    print("Status code :: ${response.statusCode}");
    print("Status code :: ${response.body}");
    if (response.statusCode == 200) {
      forecastList.clear();
      weatherModel = WeatherModel.fromJson(json.decode(response.body));
      forecastList.addAll(weatherModel.forecasts!);
      currentObservationList.add(weatherModel.currentObservation!);
      isLoading = false;
      notifyListeners();
      print(url);
    } else {
      Fluttertoast.showToast(
        msg: 'Something Went Wrong..',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      isLoading = false;
    }
    isLoading = false;
  }
}
