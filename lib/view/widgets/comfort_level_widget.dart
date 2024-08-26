import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/model/current_weather_data.dart';

class ComfortLevelWidget extends StatelessWidget {
  final CurrentWeatherData currentWeatherData;
  const ComfortLevelWidget({
    super.key,
    required this.currentWeatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeights.minHeight(context),
        Text(
          'Comfort Level',
          style: CustomFuction.textStyleFuction(
              size: 18, fontWeight: FontWeight.bold),
        ),
        CustomHeights.commonHeight(context),
        SleekCircularSlider(
          min: 0,
          max: 100,
          initialValue: currentWeatherData.currentModel.humidity!.toDouble(),
          appearance: CircularSliderAppearance(
            size: 140,
            customWidths: CustomSliderWidths(
                handlerSize: 0, trackWidth: 12, progressBarWidth: 13),
            animationEnabled: true,
            infoProperties: InfoProperties(
              bottomLabelText: "Humidity",
              bottomLabelStyle: TextStyle(
                  color: CustomColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                  height: 1.8),
            ),
            customColors: CustomSliderColors(
              hideShadow: true,
              trackColor: CustomColor.gradientColorOne.withAlpha(80),
              progressBarColors: [
                CustomColor.gradientColorOne,
                CustomColor.gradientColorTwo,
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Feels Like ${currentWeatherData.currentModel.feelsLike}",
              style: CustomFuction.textStyleFuction(
                  size: 15,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.black),
            ),
            Container(color: CustomColor.dividerLine, height: 20, width: 2),
            Text(
              'UV Index ${currentWeatherData.currentModel.uvi}',
              style: CustomFuction.textStyleFuction(
                  size: 15,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.black),
            )
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
