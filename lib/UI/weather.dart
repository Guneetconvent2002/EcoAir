import 'package:clean_air_tracker/UI/networking.dart';
// import 'package:clean_air_tracker/services/location.dart';

const ApiKey = '4b18cfa6256d780081771c0b099cceba';
const openWeather_API = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    // Location location = Location();
    // await location.getCurrentLocation();

    NetworkManager networkManager = NetworkManager(
        'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=-19.3111433551&lon=-19.3111433551&appid=$ApiKey');

    var weatherData = await networkManager.collectData();

    return weatherData;
  }

  // String getWeatherIcon(int condition) {
  //   if (condition < 300) {
  //     return '🌩';
  //   } else if (condition < 400) {
  //     return '🌧';
  //   } else if (condition < 600) {
  //     return '☔️';
  //   } else if (condition < 700) {
  //     return '☃️';
  //   } else if (condition < 800) {
  //     return '🌫';
  //   } else if (condition == 800) {
  //     return '☀️';
  //   } else if (condition <= 804) {
  //     return '☁️';
  //   } else {
  //     return '🤷‍';
  //   }
  // }

  // String getMessage(int temp) {
  //   if (temp > 25) {
  //     return 'It\'s 🍦 time in';
  //   } else if (temp > 20) {
  //     return 'Time for shorts and 👕 in';
  //   } else if (temp > 10) {
  //     return 'You\'ll need 🧣 and 🧤 in';
  //   } else {
  //     return 'Bring a 🧥 just in case in';
  //   }
  // }
}
