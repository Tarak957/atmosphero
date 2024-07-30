import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/controller/getx/global_controller.dart';
import 'package:weather_app/view/widgets/comfort_level_widget.dart';
import 'package:weather_app/view/widgets/current_weather_widget.dart';
import 'package:weather_app/view/widgets/daily_weather.dart';
import 'package:weather_app/view/widgets/header_widget.dart';
import 'package:weather_app/view/widgets/weathers_hourly.dart';
import 'package:weather_app/view/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final GlobelController globalController =
        Get.put(GlobelController(), permanent: true);

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async {
            globalController.isLoading.value = true;
            globalController.onInit();
          },
          child: Scaffold(
            body: Obx(
              () => (globalController.checkLoading().isTrue)
                  ? Center(child: loading())
                  : SingleChildScrollView(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF55ADF6),
                              Color(0x1AF2EEEE),
                              Color(0xFF85C5F9),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              CustomHeights.commonHeight(context),
                              const HeaderWidget(),
                              CustomHeights.commonHeight(context),
                              CurrentWeatherWidget(
                                currentWeatherData: globalController
                                    .getData()
                                    .getCurrentWeather(),
                                screenSize: screenSize,
                              ),
                              CustomHeights.commonHeight(context),
                              ComfortLevelWidget(
                                currentWeatherData: globalController
                                    .getData()
                                    .getCurrentWeather(),
                              ),
                              CustomHeights.commonHeight(context),
                              WeathersHourly(
                                weatherDataHourly: globalController
                                    .getData()
                                    .getHourlyWeather(),
                                screenSize: screenSize,
                              ),
                              CustomHeights.commonHeight(context),
                              DailyWeather(
                                weatherDataDaily: globalController
                                    .getData()
                                    .getDailyWeather(),
                                screenSize: screenSize,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
