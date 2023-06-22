import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/testing.dart';
import 'location.dart';
import 'colors.dart';
import 'weather.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cityName = '';
  int aqi = 0;
  DateTime lastUpdatedTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationService locationService = LocationService();
    Position? position = await locationService.getCurrentLocation();

    if (position != null) {
      getCityName(position);
      getAQIData(position);
    }
  }

  Future<void> getCityName(Position position) async {
    LocationService locationService = LocationService();
    String city = await locationService.getCityName(position);

    setState(() {
      cityName = city;
    });
  }

  Future<void> getAQIData(Position position) async {
    final apiKey = '4b18cfa6256d780081771c0b099cceba';

    final latitude = position.latitude;
    final longitude = position.longitude;

    final url =
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final aqi = jsonData['list'][0]['main']['aqi'];

      setState(() {
        this.aqi = aqi;
        lastUpdatedTime = DateTime.now();
      });
    } else {
      setState(() {
        aqi = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (aqi == -1) {
      return Scaffold(
        body: Center(
          child: Text('Failed to fetch AQI data'),
        ),
      );
    } else if (aqi == 0) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      WeatherClass weatherData = WeatherClass(aqi: aqi, cityName: cityName);
      Color fontColor = AppColors.fontColor(aqi);

      String formattedTime =
          DateFormat('d MMMM h:mm a').format(lastUpdatedTime);
      String ordinalIndicator = _getOrdinalIndicator(lastUpdatedTime.day);

      return Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(25, 30, 30, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: fontColor,
                  ),
                  Text(
                    ' ' + weatherData.cityName,
                    style: TextStyle(
                      fontSize: 23.0,
                      fontFamily: 'Montserrat',
                      // fontWeight: FontWeight.w900,
                      color: fontColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                weatherData.aqi.toString(),
                style: TextStyle(
                  fontSize: 100.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                weatherData.getAQIClassification(),
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'Montserrat',
                  // fontWeight: FontWeight.w900,
                  color: fontColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                height: 10.0,
                width: double.infinity,
                color: fontColor.withOpacity(0.20),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 400,
                child: Text(
                  weatherData.getAQIActions(),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: fontColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                height: 10.0,
                width: double.infinity,
                color: fontColor.withOpacity(0.20),
              ),
              Text(
                'Last Updated: $ordinalIndicator $formattedTime',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.0,
                    color: fontColor,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.backgroundColor(weatherData.aqi),
      );
    }
  }

  String _getOrdinalIndicator(int day) {
    if (day >= 11 && day <= 13) {
      return '${day}th';
    }
    switch (day % 10) {
      case 1:
        return '${day}st';
      case 2:
        return '${day}nd';
      case 3:
        return '${day}rd';
      default:
        return '${day}th';
    }
  }
}
