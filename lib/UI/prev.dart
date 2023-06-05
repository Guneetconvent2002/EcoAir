import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class Precaution extends StatefulWidget {
  Precaution({Key? key}) : super(key: key);

  @override
  State<Precaution> createState() => _PrecautionState();
}

class _PrecautionState extends State<Precaution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 35, 0, 0), // 20, 35, 20, 0
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.arrow_back_ios)),

                // Text which says "Home"
                const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            // an icon and text for wind speed and the value of wind speed
            Row(
              children: [
                const Icon(
                  Icons.wind_power_rounded,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Wind Speed",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "10 km/h",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // an icon and text for wind direction with the value of wind direction and a compass icon
            Row(
              children: [
                const Icon(
                  Icons.arrow_upward_rounded,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Wind Direction",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "N",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
            // Text which says "Pollutants"
            const Text(
              "Pollutants",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            // a list of text with bullet points, which says methane, carbon dioxide, sulphur dioxide, particulate matter
            const Text(
              "• Methane",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Carbon Dioxide",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Sulphur Dioxide",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Particulate Matter",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            // a text which says "Preventions" and list which gives preventive measures from bad AQI using bullet points
            const Text(
              "Preventions",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Wear a mask",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Avoid outdoor activities",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Avoid using vehicles",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "• Avoid using fire",
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
