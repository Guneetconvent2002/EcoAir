import 'dart:convert';

class WeatherClass {
  final int aqi;
  final String cityName;

  WeatherClass({required this.aqi, required this.cityName});

  String getAQIClassification() {
    if (aqi <= 50) {
      return 'Good';
    } else if (aqi <= 100) {
      return 'Moderate';
    } else if (aqi <= 150) {
      return 'Unhealthy for Sensitive Groups';
    } else if (aqi <= 200) {
      return 'Unhealthy';
    } else if (aqi <= 300) {
      return 'Very Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  String getAQIActions() {
    if (aqi <= 50) {
      return 'No specific protection methods are required.\n\nEnjoy outdoor activities as usual. 😄🌳';
    } else if (aqi <= 100) {
      return 'No specific protection methods are necessary for the general population.\n\nHowever, unusually sensitive individuals may consider reducing prolonged or heavy outdoor exertion. 🚶‍♀️💨';
    } else if (aqi <= 150) {
      return 'Sensitive individuals: Limit outdoor activities and use face masks (N95/N99). 🚫🌞😷';
    } else if (aqi <= 200) {
      return 'General population: Reduce outdoor activities, especially heavy exertion. 🏋️‍♀️🌁\n\nSensitive individuals: Avoid heavy exertion, use face masks (N95/N99). ⚠️😷';
    } else if (aqi <= 300) {
      return 'Everyone: Minimize outdoor activities. ⛔️🏞️\n\nSensitive individuals: Avoid outdoor activity, use face masks (N95/N99). 🚷😷\n\nConsider using air purifiers indoors. 🏠🍃';
    } else {
      return 'Everyone: Avoid outdoor activity, stay indoors. 🚫🌳🏡\n\nKeep windows and doors closed. 🚪❌\n\nUse air purifiers with HEPA filters indoors. 🌬️🔍🏠\n\nWear face masks (N95/N99) if necessary to go outside. 😷🌁';
    }
  }
}
