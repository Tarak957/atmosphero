import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/model/daily_weather_model.dart';

class DailyWeather extends StatelessWidget {
  const DailyWeather(
      {super.key, required this.weatherDataDaily, required this.screenSize});
  final WeatherDataDaily weatherDataDaily;
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.46,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColor.grey.withOpacity(0.8),
            CustomColor.white,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Next Days",
            style: CustomFuction.textStyleFuction(
              size: 18,
              fontWeight: FontWeight.bold,
              color: CustomColor.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Days',
                  style: CustomFuction.textStyleFuction(
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.black),
                ),
              ),
              const SizedBox(width: 16),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Text(
                  'Max° / Min°',
                  style: CustomFuction.textStyleFuction(
                      size: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.35,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      height: screenSize.height * 0.05,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            getDay(weatherDataDaily.daily[index].dt),
                            style: CustomFuction.textStyleFuction(
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: CustomColor.black,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height * 0.09,
                            width: screenSize.width * 0.09,
                            child: Image.asset(
                                'assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png'),
                          ),
                          Text(
                            '${weatherDataDaily.daily[index].temp!.max}°/${weatherDataDaily.daily[index].temp!.min}°',
                            style: CustomFuction.textStyleFuction(
                              size: 16,
                              fontWeight: FontWeight.w500,
                              color: CustomColor.black,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final y = DateFormat('EEE').format(time);
    return y;
  }
}
