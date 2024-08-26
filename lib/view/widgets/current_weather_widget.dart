import 'package:flutter/material.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/model/current_weather_data.dart';

class CurrentWeatherWidget extends StatelessWidget {
  const CurrentWeatherWidget(
      {super.key, required this.currentWeatherData, required this.screenSize});
  final CurrentWeatherData currentWeatherData;
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentWeatherContainer(),
        CustomHeights.commonHeight(context),
        moreDetailsWidget(context)
      ],
    );
  }

  Widget currentWeatherContainer() {
    return Container(
      height: screenSize.height * 0.23,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColor.grey.withOpacity(0.8),
            CustomColor.white,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
              'assets/weather/${currentWeatherData.currentModel.weather![0].icon}.png'),
          Center(
            child: Text(
              "${currentWeatherData.currentModel.temp!.floor()}°",
              style: CustomFuction.textStyleFuction(
                  size: 80,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget moreDetailsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Container(
              height: screenSize.height * 0.07,
              width: screenSize.width * 0.15,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                // color: CustomColor.colorCard,
                gradient: LinearGradient(
                  colors: [
                    CustomColor.grey.withOpacity(0.8),
                    CustomColor.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/icons/windspeed.png'),
            ),
            const SizedBox(height: 10),
            const Text('Wind Speed'),
            Text(
              "${currentWeatherData.currentModel.windSpeed!.floor()} km/h",
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: screenSize.height * 0.07,
              width: screenSize.width * 0.15,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                // color: CustomColor.colorCard,
                gradient: LinearGradient(
                  colors: [
                    CustomColor.grey.withOpacity(0.8),
                    CustomColor.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/icons/clouds.png'),
            ),
            const SizedBox(height: 10),
            const Text('Clouds'),
            Text(
              "${currentWeatherData.currentModel.clouds}%",
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: screenSize.height * 0.07,
              width: screenSize.width * 0.15,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                // color: CustomColor.colorCard,
                gradient: LinearGradient(
                  colors: [
                    CustomColor.grey.withOpacity(0.8),
                    CustomColor.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/icons/humidity.png'),
            ),
            const SizedBox(height: 10),
            const Text('Humidity'),
            Text(
              "${currentWeatherData.currentModel.humidity}%",
            ),
          ],
        ),
      ],
    );
  }
}
