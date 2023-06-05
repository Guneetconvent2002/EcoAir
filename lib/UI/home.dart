import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'networking.dart';
import 'prev.dart';
// import 'weather.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  var aqi, pm25, pm10, o3, no2, so2, co;
  Position? _currentPosition;
  String? _currentAddress;

  var lat, long;

  Future<dynamic> getLocationWeather() async {
    NetworkManager networkManager = NetworkManager(
        'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=-19.3111433551&lon=-19.3111433551&appid=4b18cfa6256d780081771c0b099cceba');

    var weatherData = await networkManager.collectData();
    aqi = weatherData[1][0]['main']['aqi'];
    pm25 = weatherData[1][0]['components']['pm2_5'];
    pm10 = weatherData[1][0]['components']['pm10'];
    o3 = weatherData[1][0]['components']['o3'];
    no2 = weatherData[1][0]['components']['no2'];
    so2 = weatherData[1][0]['components']['so2'];
    co = weatherData[1][0]['components']['co'];

    return weatherData;
  }

  String weather(aqi) {
    if (aqi == 1) {
      return "Good";
    } else if (aqi == 2) {
      return "Moderate";
    } else if (aqi == 3) {
      return "Unhealthy for Sensitive Groups";
    } else if (aqi == 4) {
      return "Unhealthy";
    } else if (aqi == 5) {
      return "Very Unhealthy";
    } else {
      return "Hazardous";
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 35, 0, 0), // 20, 35, 20, 0
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib\Image\cloud1.png'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  // All the items in the column should align to the left
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Yamuna Nagar, Haryana",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Station __ far away",
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
                const Spacer(),
                // location icon button which when clicked opens the location page
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on),
                  iconSize: 40,
                  color: Colors.black,
                ),
                const Spacer(),
              ],
            ),
            Spacer(),
            // a button which has grey background and black text saying "daily" and size = 30 which when pressed does something
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Daily",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // text which shows the value of aqi variable and size = 30 and bold
                Text(
                  weather(aqi),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                // an icon button which when pressed opens the precautions page
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Precaution()));
                  },
                  icon: const Icon(Icons.info_outline),
                  iconSize: 40,
                  color: Colors.black,
                ),
              ],
            ),
            Spacer(),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Weekly",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Monthly",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            const Text(
              "Air quailty is not good",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Stay inside and wear a mask",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // an image of a cloud which is rotated 90 degrees and offset by 20 pixels and width wrapping the entire screen which is present in Image folder under lib
            // Image.asset(
            //   'lib/Image/cloud.png',
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   fit: BoxFit.fill,
            // ),
          ],
        ),
      ),
    );
  }
}
