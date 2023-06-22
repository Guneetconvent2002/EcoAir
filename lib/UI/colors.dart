import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor(int aqi) {
    if (aqi <= 50) {
      return Color(0xFFBCE29E); // Light green
    } else if (aqi <= 100) {
      return Color(0xFFE7F097); // Light yellow
    } else if (aqi <= 150) {
      return Color(0xFFF9895C); // Light orange
    } else if (aqi <= 200) {
      return Color(0xFFF75A5A); // Light red
    } else if (aqi <= 300) {
      return Color(0xFFC278D8); // Light purple
    } else {
      return Color(0xFFA42D48); // Dark red
    }
  }

  static Color fontColor(int aqi) {
    if (aqi <= 100) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
