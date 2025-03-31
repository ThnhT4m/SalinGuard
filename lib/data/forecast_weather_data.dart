import 'package:flutter/material.dart'; // Needed for IconData

class ForecastWeatherData {
  // These could be final if the data is fetched once, or vars if they update
  String currentTemp = "31°C"; // Default/Example
  String humidity = "75%";
  String feelsLikeTemp = "34°C";
  IconData nextHourIcon = Icons.wb_cloudy_outlined;
  String nextHourCondition = "Ít mây";
  String nextHourPrecipitation = "Khả năng mưa thấp";
}
