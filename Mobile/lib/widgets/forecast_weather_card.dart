import 'package:flutter/material.dart';
import 'package:sagu/const/constant.dart'; // Đảm bảo secondaryColor được định nghĩa và phù hợp
import 'package:sagu/data/forecast_weather_data.dart'; // Đảm bảo class này tồn tại và hoạt động

class ForecastWeatherCard extends StatelessWidget {
  const ForecastWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Truy cập dữ liệu (giả sử có class ForecastWeatherData)
    final weatherData = ForecastWeatherData(); // Cần đảm bảo bạn có dữ liệu này

    // Thêm Padding bao bọc bên ngoài AspectRatio
    return Padding(
      padding: const EdgeInsets.all(6.0), // Padding 20px xung quanh card
      child: AspectRatio(
        aspectRatio: 10 / 12,
        child: Card(
          // >>> Thêm thuộc tính color tại đây <<<
          color: cardBackgroundColor, // Đặt màu nền cho Card
          elevation: 3, // Giữ lại hoặc điều chỉnh độ nổi nếu cần
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            // Padding bên trong card
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 12.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hàng 1: Nhiệt độ
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weatherData.currentTemp,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Text(
                  "Cảm giác như ${weatherData.feelsLikeTemp}",
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryColor, // Kiểm tra màu này
                  ),
                ),

                Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      color: secondaryColor, // Kiểm tra màu này
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Độ ẩm: ${weatherData.humidity}",
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryColor, // Kiểm tra màu này
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1 giờ tới:",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: secondaryColor, // Kiểm tra màu này
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${weatherData.nextHourCondition}. ${weatherData.nextHourPrecipitation}.",
                            style: TextStyle(
                              fontSize: 14,
                              color: secondaryColor, // Kiểm tra màu này
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      weatherData
                          .nextHourIcon, // Đảm bảo icon này có trong dữ liệu
                      color: secondaryColor, // Kiểm tra màu này
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
