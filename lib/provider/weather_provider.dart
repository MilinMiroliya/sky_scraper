import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sky_scraper/models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  bool isLoading = false;
  List<WeatherModel> weatherDataList = [];
  late String place;

  getWeatherData() async {
    isLoading = true;
    String baseUrl = "https://yahoo-weather5.p.rapidapi.com/weather";
    String location = "Surat";

    place = location;

    Uri url = Uri.parse("$baseUrl?location=$location");
    var response = await http.get(url, headers: {
      "X-RapidAPI-Key": "2f2d1e300dmshdfa09686a5e393fp199bd3jsn0e426b7cae94",
      "X-RapidAPI-Host": "yahoo-weather5.p.rapidapi.com",
    });
    print("status code:  ${response.statusCode}");
    if (response.statusCode == 200) {
      weatherDataList.add(weatherModelFromJson(response.body));
      print(weatherDataList);
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
