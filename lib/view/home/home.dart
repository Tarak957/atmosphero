import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/controller/core/constants.dart';
import 'package:weather_app/controller/getx/global_controller.dart';
import 'package:weather_app/view/widgets/comfort_level_widget.dart';
import 'package:weather_app/view/widgets/current_weather_widget.dart';
import 'package:weather_app/view/widgets/daily_weather.dart';
import 'package:weather_app/view/widgets/header_widget.dart';
import 'package:weather_app/view/widgets/settings_permission.dart';
import 'package:weather_app/view/widgets/weathers_hourly.dart';
import 'package:weather_app/view/widgets/loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController globalController =
        Get.put(GlobalController(), permanent: true);

    var screenSize = MediaQuery.of(context).size;
    // var screenSize = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        globalController.isLoading.value = true;
        globalController.onInit();
      },
      child: Scaffold(
        body: Obx(
          () => (globalController.checkLoading().isTrue)
              ? Container(
                  decoration: CustomFuction.gradient,
                  child: Center(child: loading()),
                )
              : globalController.errorMessage.isNotEmpty ||
                      globalController.weatherData.value.current == null
                  ? Container(
                      width: double.infinity,
                      decoration: CustomFuction.errorGradient,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/icons/location.json",
                            height: 120,
                            width: 120,
                          ),
                          Text(
                            "Location permission required",
                            style: TextStyle(
                                color: CustomColor.red,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "App > App permissions > Location > Always",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showPermissionDialog();
                            },
                            child: Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: CustomColor.red,
                              ),
                              child: const Center(
                                child: Text(
                                  "Go to settings",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        decoration: CustomFuction.gradient,
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
    );
  }
}
