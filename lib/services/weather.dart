import 'package:clima_weather/services/location.dart';
import 'package:clima_weather/services/networking.dart';

const apiKey = '54b7c7f7e1d8f7b88aa3291875239b77';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      print('Error fetching city weather: $e');
      return null; // or handle error appropriately
    }
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();

      if (location.latitude == null || location.longitude == null) {
        print('Location permissions denied or location not available.');
        return null; // Handle this case appropriately in the UI
      }

      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      print('Error fetching location weather: $e');
      return null; // or handle error appropriately
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
