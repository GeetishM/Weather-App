import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  final _weatherService = Weatherservice('bf1d30f81f548b1450dfa1227ce0df69');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city name
    String cityName = await _weatherService.getCurrentcity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather Animations
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'lib/assets/sunny.json';

    switch(mainCondition.toLowerCase()){
      case'cloud':
      case'mist':
      case'smoke':
      case'haze':
      case'fog':
        return 'lib/assets/cloudy.json';
      case'rain':
      case'dizzle':
      case'shower rain':
        return 'lib/assets/rain.json';
      case'thunderstorm':
        return 'lib/assets/thunder.json';
      default:
        return 'lib/assets/sunny.json';
      
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    _fetchWeather();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "Loading Page....."),
            SizedBox(height: 20), // Add some spacing
            // animation
            
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            SizedBox(height: 20), // Add some spacing
            // temperature
            Text('${_weather?.temperature.round()}°C'),
            SizedBox(height: 20), // Add some spacing
            // weather condition
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    ),
  );
}
}