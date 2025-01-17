import 'dart:developer';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/api_service/get_api_resp.dart';
import 'package:weather_app/model/weather_data_model.dart';
import 'package:weather_app/view/widgets/settings_permission.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxInt currentIndex = 0.obs;

  RxBool checkLoading() => isLoading;
  RxDouble getLongitude() => longitude;
  RxDouble getLatitude() => latitude;

  final weatherData = WeatherData().obs;
  final RxString errorMessage = ''.obs;

  WeatherData getData() {
    return weatherData.value;
  }

  RxInt getIndex() {
    return currentIndex;
  }

  @override
  void onInit() {
    super.onInit();
    if (isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }
  }

  Future getLocation() async {
    try {
      bool isLocationEnabled;
      LocationPermission locationPermission;

      isLocationEnabled = await Geolocator.isLocationServiceEnabled();

      if (!isLocationEnabled) {
        errorMessage.value = "Location service is not enabled";

        throw Exception("Location service is not enabled");
      }

      locationPermission = await Geolocator.checkPermission();

      if (locationPermission == LocationPermission.deniedForever) {
        errorMessage.value = "Location permission is denied forever";
        showPermissionDialog();
        throw Exception("Location permission is denied forever");
      } else if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          errorMessage.value = "Location permission is denied";
          showPermissionDialog();
          throw Exception("Location permission is denied");
        }
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      final weather = await ApiService()
          .getWeatherData(position.latitude, position.longitude);

      if (weather == null) {
        errorMessage.value = "Failed to fetch weather data";
        throw Exception("Failed to fetch weather data");
      }

      weatherData.value = weather;
      isLoading.value = false;
    } catch (e) {
      log("Error: $e");
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }
}
