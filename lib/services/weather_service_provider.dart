
import 'dart:convert';

import 'package:apiweatherapp/models/weather_response_model.dart';
import 'package:apiweatherapp/secrets/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
class WeatherServiceProvider extends ChangeNotifier{


  WeatherModel? _weather;

  WeatherModel? get weather=>_weather;

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  String _error="";
  String get error=>_error;

  Future<void>fetchWeatherDataByCity(String city)async{

    _isLoading=true;
    _error="";
    //https://api.openweathermap.org/data/2.5/weather?q=dubai&appid=34cf140ea3d6eec0b4f05a2a7b85b4dd&units=metric
    try{

      final String apiUrl="${APIEndPoints().cityUrl}${city}&appid=${APIEndPoints().apiKey}${APIEndPoints().unit}";
      print(apiUrl);

      final response=await http.get(Uri.parse(apiUrl));
      print(response.statusCode);
      if(response.statusCode==200){
        print("hello");
        final data=jsonDecode(response.body);
        print(data);

        _weather=WeatherModel.fromJson(data);
        notifyListeners();
      }else
      {
        _error="failed to load data";
      }


    }
    catch(e){
      _error="Failed to load data $e";
      notifyListeners();
    }finally{
      _isLoading=false;
      notifyListeners();
    }
  }

}